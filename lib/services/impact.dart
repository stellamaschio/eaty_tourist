import 'package:eaty_tourist/models/entities/entities.dart';
import 'package:eaty_tourist/services/server_strings.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';

// this class is used for getting the data from the impact server

class ImpactService {
  
  ImpactService(this.prefs) {
    updateBearer();   //(dio's attribute) allows to save tokens
  }
  
  Preferences prefs;

  final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.backendBaseUrl));

  // get saved token from Preferences
  String? retrieveSavedToken(bool refresh) {
    if (refresh) {
      return prefs.impactRefreshToken;    
    } else {
      return prefs.impactAccessToken;
    }
  }

  // get saved token and if it is not null --> check it
  bool checkSavedToken({bool refresh = false}) {    // default access token
    String? token = retrieveSavedToken(refresh);
    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return ImpactService.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  // check if the token is valid, if yes check the iss claim and the user role
  // this method is static because we might want to check the token outside the class itself
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    // decode the token
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    //Check the iss claim
    if (decodedToken['iss'] == null) {
      return false;
    } 
    else {
      if (decodedToken['iss'] != ServerStrings.issClaim) {
        return false;
      } 
    } 

    //Check that the user is a patient
    if (decodedToken['role'] == null) {
      return false;
    } else {
      if (decodedToken['role'] != ServerStrings.patientRoleIdentifier) {
        return false;
      } //else
    } //if-else

    return true;
  } //checkToken

  // make the call to get the tokens
  Future<bool> getTokens(String username, String password) async {
    try {
      Response response = await _dio.post(
        '${ServerStrings.authServerUrl}token/',
        data: {'username': username, 'password': password},
        options: Options(
          contentType: 'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {"Accept": "application/json"}
        )
      );
      
      // if both the checks are ok, update the tokens with the newest obtained from the server
      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } 
      else {
        return false;
      }
    } 
    catch (e) {
      print(e);
      return false;
    }
  }

  // make the call to refresh the tokens
  Future<bool> refreshTokens() async {
    String? refToken = await retrieveSavedToken(true);
    try {
      Response response = await _dio.post(
          '${ServerStrings.authServerUrl}refresh/',
          data: {'refresh': refToken},
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateBearer() async {
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    String? token = await prefs.impactAccessToken;
    if (token != null) {
      _dio.options.headers = {'Authorization': 'Bearer $token'};
    }
  }

  Future<void> getPatient() async {
    await updateBearer();
    Response r = await _dio.get('study/v1/patients/active');
    prefs.impactUsername = r.data['data'][0]['username'];
    return r.data['data'][0]['username'];
  }

  Future<List<Calories>> getDataCaloriesFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
        'data/v1/calories/patients/${prefs.impactUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
    List<dynamic> data = r.data['data'];
    List<Calories> cal = [];
    for (var daydata in data) {
      String day = daydata['date'];
      for (var dataday in daydata['data']) {
        String hour = dataday['time'];
        String datetime = '${day}T$hour';
        DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
        Calories calnew = Calories(null, double.parse(dataday['value']), timestamp);
        if (!cal.any((e) => e.dateTime.isAtSameMomentAs(calnew.dateTime))) {
          cal.add(calnew);
        }
      }
    }
    var callist = cal.toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return callist;
  }

  Future<List<Steps>> getDataStepsFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
        'data/v1/steps/patients/${prefs.impactUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
    List<dynamic> data = r.data['data'];
    List<Steps> step = [];
    for (var daydata in data) {
      String day = daydata['date'];
      for (var dataday in daydata['data']) {
        String hour = dataday['time'];
        String datetime = '${day}T$hour';
        DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
        Steps stepsnew = Steps(null, int.parse(dataday['value']), timestamp);
        if (!step.any((e) => e.dateTime.isAtSameMomentAs(stepsnew.dateTime))) {
          step.add(stepsnew);
        }
      }
    }
    var steplist = step.toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return steplist;
  }

  Future<List<Distance>> getDataDistanceFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
        'data/v1/distance/patients/${prefs.impactUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
    List<dynamic> data = r.data['data'];
    List<Distance> distance = [];
    for (var daydata in data) {
      String day = daydata['date'];
      for (var dataday in daydata['data']) {
        String hour = dataday['time'];
        String datetime = '${day}T$hour';
        DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
        Distance distancenew = Distance(null, double.parse(dataday['value']), timestamp);
        if (!distance.any((e) => e.dateTime.isAtSameMomentAs(distancenew.dateTime))) {
          distance.add(distancenew);
        }
      }
    }
    var distancelist = distance.toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return distancelist;
  }

  DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }

}
