import 'package:eaty_tourist/services/server_strings.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:eaty_tourist/services/server_strings.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';

class ImpactService {
  ImpactService(this.prefs);
  Preferences prefs;

  final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.backendBaseUrl));

  // ottenere token salvato
  String? retrieveSavedToken(bool refresh) {
    if (refresh) {
      return prefs.impactRefreshToken;    // sta solo accendendo alle variabili di un oggetto Preferences
    } else {
      return prefs.impactAccessToken;
    }
  }

  // ottiene il token salvato e se non è null lo controlla
  bool checkSavedToken({bool refresh = false}) {    //chiama di default il token di accesso
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

  // controlla se il token è valido, se si controlla l'iss claim e il ruolo dell'utente
  // this method is static because we might want to check the token outside the class itself
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    // decodifica del token
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
      
      // se entrambi i check vengono superati aggiorna i token con quelli appena ottenuti dal server
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
}
