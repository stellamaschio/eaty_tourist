import 'package:eaty_tourist/models/barObj.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:eaty_tourist/models/db.dart';
import 'package:eaty_tourist/models/entities/entities.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<Calories> calories = [];
  late List<Steps> steps = [];
  late List<Distance> distance = [];

  double selectedCalories = 0;
  double selCal = 0;
  int selectedSteps = 0;
  double selectedDistance = 0;
  List<Selected> selectedByTime = [];
  List<Selected> selectedUntilNow = [];
  List<Selected> selectedAll = [];
  List<Selected> temp = [];
  List<Selected> lastData = [];   // variable for last data used for displaying data in statistics
  List<Selected> lastDataBar = [];    // variable for last data used for print the bars of the graphic

  late DateTime lastSelTime;
  late DateTime lastSelTimeBar;
  late DateTime firstDataDay;

  final AppDatabase db;

  // data fetched from external services or db
  late List<Calories> _calories;
  late List<Steps> _steps;
  late List<Distance> _distance;

  // selected day of data to be shown --> date of yesterday
  //page home date (foodbar)
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  // selected day of data to be shown --> date of yesterday
  // don't change usuing the application
  DateTime todayDate = DateTime.now().subtract(const Duration(days: 1));

  //selected day of data to be shown --> date of yesterday
  //page statistics date
  late DateTime statDate = DateTime.now().subtract(const Duration(days: 1));

  final ImpactService impactService;
  late DateTime lastFetch;

  bool doneInit = false;

  HomeProvider(this.impactService, this.db) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _checkEmpty();
    await dayLastTime(showDate);
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  // add a new Selected object to the db if the db is empty
  // fixed errors for new user that have no data 
  Future<void> _checkEmpty() async {
    selectAll();
    if(selectedAll.isEmpty){
      await saveDay(showDate);
    }
    firstDataDay = (await db.selectedDao.findFirstDayInDb())!.dateTime;
    return;
  }

  Future<DateTime?> _getLastFetch() async {
    var dataCal = await db.caloriesDao.findAllCalories();
    if (dataCal.isEmpty) {
      // if db Calories is empty
      return null;
    }
    return dataCal.last.dateTime;
  }

  //Method to fetch all data
  //This means lastFetch equals _getLastFetch(), but if _getLastFetch() is null
  //then a equals DateTime.now().subtract(const Duration(days: 2))
  Future<void> _fetchAndCalculate() async {
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 2));

    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return;
    }

    _calories = await impactService.getDataCaloriesFromDay(lastFetch);
    for (var element in _calories) {
      db.caloriesDao.insertCalories(element);
    } // db add to the table Calories

    _steps = await impactService.getDataStepsFromDay(lastFetch);
    for (var element in _steps) {
      db.stepsDao.insertSteps(element);
    } // db add to the table Steps

    _distance = await impactService.getDataDistanceFromDay(lastFetch);
    for (var element in _distance) {
      db.distanceDao.insertDistance(element);
    } // db add to the table Distance

    notifyListeners();
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    // check for the first and last data in db
    var firstDay = await db.caloriesDao.findFirstDayInDb();
    var lastDay = await db.caloriesDao.findLastDayInDb();

    if (showDate.day == todayDate.day) {
      this.showDate = showDate;

      // get the calories from the db Calories
      calories = await db.caloriesDao.findCaloriesbyTime(
          DateUtils.dateOnly(showDate),
          DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

      notifyListeners();
    } 
    // check if the day we want to show has data
    else if (showDate.isAfter(lastDay!.dateTime) || showDate.isBefore(firstDay!.dateTime)) {
      return;
    }
  }

  // method for set this variables
  void setSelected(double val) {
    selectedCalories = val;
    selectedSteps = val.toInt();
    selectedDistance = val;
    selCal = val;

    notifyListeners();
  }

  // select the data we want to add to db Selected
  Future<void> selectCalories(int startMinute, int minuteAdd, DateTime startTime, DateTime endTime, BuildContext context) async{
    // if there isn't enough data today, we show a snack bar to inform the user
    if (startMinute > (calories.length - 1)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange.shade400,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(8),
          content: Row(
            children: [
              const Icon(
                MdiIcons.databaseAlertOutline,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('Impact msg: there is no data today',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    } 
    else {
      for (int i = 1; i <= minuteAdd; i++) {
        selCal = selCal + calories[startMinute + i].value;
      }
      await selectStepsDistance(startTime, endTime);
      notifyListeners();
    }
  }

  // select the data: steps and distance we want to add to db Selected
  Future<void> selectStepsDistance(DateTime startTime, DateTime endTime) async{
    
    steps = await db.stepsDao.findStepsbyTime(startTime, endTime);
    distance = await db.distanceDao.findDistancebyTime(startTime, endTime);

    for (var element in steps) {
      selectedSteps = selectedSteps + element.value;
      notifyListeners();
    }

    for (var element in distance) {
      selectedDistance = selectedDistance + element.value;
      notifyListeners();
    }
  }

  // save calories, steps, and distance made during the day with the app in Selected db
  Future<void> saveDay(DateTime time) async {
    // time of the beginning of the day
    DateTime startTime = DateTime(time.year, time.month, time.day, 00, 01);
    // time when we stop the activity
    DateTime endTime = time;
    DateTime selTime = time;

    selectedCalories = selCal;

    selectedUntilNow = await db.selectedDao.findSelectedbyTime(startTime, endTime);

    // if there was NO previous activity
    if (selectedUntilNow.isEmpty) {
      selTime = time;
      // selectedCalories, selectedSteps, selectedDistance remain the same updated
      // by the methods selectCalories() and selectStepsDistance()

      // insert a new element in Selected db
      await db.selectedDao.insertSelected(Selected(null, selectedCalories, selectedSteps, selectedDistance, selTime));
      // select element in Selected db by time
      selectedByTime = await db.selectedDao.findSelectedbyTime(startTime, endTime);

      lastData.clear();   // clear the lastData list from previous data
      lastData.add(selectedByTime.last);  // the new lastData element is the last inserted in the db Selected
      lastSelTime = selTime;  // lastSelTime is the time of the last element inserted in the db Selected
      setSelected(0);   // clear the variables

      notifyListeners();
    } 
    // if there was previous activity
    else {
      selTime = time;

      selectedCalories = selectedCalories + selectedUntilNow.last.calories;
      selectedSteps = selectedSteps + selectedUntilNow.last.steps;
      selectedDistance = selectedDistance + selectedUntilNow.last.distance;

      // insert a new element in Selected db
      await db.selectedDao.insertSelected(Selected(null, selectedCalories, selectedSteps, selectedDistance, selTime));
      // select element in Selected db by time
      selectedByTime =  await db.selectedDao.findSelectedbyTime(startTime, endTime);

      lastData.clear();   // clear the lastData list from previous data
      lastData.add(selectedByTime.last);  // the new lastData element is the last inserted in the db Selected
      lastSelTime = selTime;  // lastSelTime is the time of the last element inserted in the db Selected
      setSelected(0);   // clear the variables

      notifyListeners();
    }
  }

  // select data by a time range in a day
  // used in Statistics page to select the data of the day of which we want to see the data
  Future<void> getSelectedByTime(DateTime startTime, DateTime endTime, DateTime date) async {
    // check for the first and last data in db
    var firstDay = await db.caloriesDao.findFirstDayInDb();
    var lastDay = await db.caloriesDao.findLastDayInDb();

    // if date is before the first day in which we insert data in db 
    if (date.isBefore(firstDay!.dateTime)) {
      return;
    } 
    // if date is today or date is between the first and the last day in which we insert data in db 
    else if ((date.day == todayDate.day) ||
        date.isBefore(lastDay!.dateTime) && date.isAfter(firstDay.dateTime)) {
      
      // set the date of the two different page
      showDate = date;
      statDate = date;

      // select element in Selected db by time
      selectedByTime = await db.selectedDao.findSelectedbyTime(startTime, endTime);

      // if there is no data in the Selected db
      if (selectedByTime.isEmpty) {
        // insert an elment with all the value set to 0 and the time of today
        await db.selectedDao.insertSelected(Selected(null, 0, 0, 0, date));
        selectedByTime = await db.selectedDao.findSelectedbyTime(startTime, endTime);
        lastData.clear();   // clear the lastData list from previous data
        lastData.add(selectedByTime.last);    // the new lastData element is the last inserted in the db Selected
        notifyListeners();
        return;
      } 
      else {
        lastData.clear();   // clear the lastData list from previous data
        lastData.add(selectedByTime.last);    // the new lastData element is the last inserted in the db Selected
        notifyListeners();
        return;
      }
    } 
    else {
      return;
    }
  }

  // select last data in that day
  // used in Statistics page to select the data of the day of which we want to see the data
  Future<void> dayLastTime(DateTime time) async {
    // select all the element in db Selected
    selectAll();

    // for every element in db Selected, select only the element of that day
    for (var element in selectedAll) {
      if ((element.dateTime.month == time.month) && (element.dateTime.day == (time.day))) {
        temp.add(element);
      }
    }

    // if there are no element today in db and time is today
    if (temp.isEmpty && time.day == todayDate.day) {
      lastData.clear();   // clear the lastData list from previous data
      lastData.add(Selected(null, 0, 0, 0, time));  // add to lastData an element with all the values set to zero and time
      lastSelTime = time; // lastSelTime is the time of the element in lastData
      return;
    } 
    // if there are no element and time is after today
    else if (temp.isEmpty && time.isAfter(todayDate)) {
      return;
    }
    // check for previous day in which there can be no data inserted
    else if (temp.isEmpty && time.isBefore(firstDataDay)) {
      lastData.clear();   // clear the lastData list from previous data
      lastData.add(Selected(null, 0, 0, 0, time));  // add to lastData an element with all the values set to zero and time
      lastSelTime = lastData.last.dateTime;   // lastSelTime is the time of the element in lastData
    } 
    // if there is element in temp
    else {
      lastData.clear();   // clear the lastData list from previous data
      lastData.add(temp.last);    // add to lastData the last element of the list temp
      lastSelTime = lastData.last.dateTime;   // lastSelTime is the time of the element in lastData
      temp = [];    // clear temp list from previous data
    }
  }

  // select last data in that day
  // used in Graphic page to select the data of the day of which we want to see the data
  // used for bars of the graphic
  Future<void> dayLastTimeBars(DateTime time) async {
    // select all the element in db Selected
    selectAll();

    // for every element in db Selected, select only the element of that day
    for (var element in selectedAll) {
      if ((element.dateTime.month == time.month) && (element.dateTime.day == (time.day))) {
        temp.add(element);
      }
    }

    // if there are no element today in db and time is today
    if (temp.isEmpty && time.day == todayDate.day) {
      lastDataBar.clear();    // clear the lastDataBar list from previous data
      lastDataBar.add(Selected(null, 0, 0, 0, time));   // add to lastDataBar an element with all the values set to zero and time
      lastSelTimeBar = time;   // lastSelTimeBar is the time of the element in lastData
      return;
    } 
    // if there are no element today in db and time is today
    // and time is out of the range of the times in db
    else if (temp.isEmpty && (time.isBefore(firstDataDay) || time.isAfter(todayDate))) {
      lastDataBar.clear();    // clear the lastDataBar list from previous data
      lastDataBar.add(Selected(null, 0, 0, 0, time));   // add to lastDataBar an element with all the values set to zero and time
      lastSelTimeBar = lastDataBar.last.dateTime;   // lastSelTimeBar is the time of the element in lastData
    } 
    // if there are no element today in db and time is today
    // and time is in the range of the times in db
    else if (temp.isEmpty && (time.isAfter(firstDataDay) || time.isBefore(todayDate))) {
      lastDataBar.clear();    // clear the lastDataBar list from previous data
      lastDataBar.add(Selected(null, 0, 0, 0, time));   // add to lastDataBar an element with all the values set to zero and time
      lastSelTimeBar = lastDataBar.last.dateTime;   // lastSelTimeBar is the time of the element in lastData
    } 
    else {
      lastDataBar.clear();    // clear the lastDataBar list from previous data
      lastDataBar.add(temp.last);   // add to lastDataBar the last element of the list temp
      lastSelTimeBar = lastDataBar.last.dateTime;  // lastSelTimeBar is the time of the element in lastData
      temp = [];  // clear temp list from previous data
    }
  }

  // set showDate
  void setShowDate(DateTime date) {
    showDate = date;
  }

  // set statDate
  void setStatDate(DateTime date) {
    statDate = date;
  }

  // select all the element in db Selected
  Future<void> selectAll() async {
    selectedAll = await db.selectedDao.findAllSelected();
  }

  // delete the last Selected in db
  Future<void> deleteSelected() async {
    selectAll();
    await db.selectedDao.deleteSelected(selectedAll.last);
    notifyListeners();
  }

  // delete the last Selected in db that day
  Future<void> deleteSelectedDay(DateTime day) async {
    getSelectedByTime(
      DateUtils.dateOnly(day),
      DateTime(day.year, day.month, day.day, 23, 59),
      day,
    );
    await db.selectedDao.deleteSelected(selectedByTime.last);
    notifyListeners();
  }


  //----------------------------
  // Methods used to draw Statistics page and Graphic
  //----------------------------

  List<BarChartGroupData> items = [];
  double val_max = 1000;
  double rap_max = 0;

  final Color otherDaysBarColor = const Color.fromARGB(255, 228, 139, 238);
  final Color selDayBarColor = const Color.fromARGB(255, 216, 30, 236);

  // this method makes the single bar 
  BarObj makeDay(DateTime day, DateTime lastTime) {
    // if day is after the last time we inserted data but  the last time is also today
    if (day.isAfter(lastTime) && day.day == lastTime.day) {
      // update data bar and time of the selected day
      dayLastTimeBars(day);
      return BarObj(
          dateTime: lastSelTimeBar,
          weekDay: lastSelTimeBar.weekday,
          calories: lastDataBar.last.calories);
    } 
    // if day is after the last time we inserted data
    else if (day.isAfter(lastTime)) {
      // update data bar and time of the selected day
      dayLastTimeBars(day);
      return BarObj(dateTime: day, weekDay: day.weekday, calories: 0);
    } 
    // if day is before the first time we inserted data
    else if (day.isBefore(firstDataDay)) {
      return BarObj(dateTime: day, weekDay: day.weekday, calories: 0);
    } 
    else {
      // update data bar and time of the selected day
      dayLastTimeBars(day);
      return BarObj(
          dateTime: lastSelTimeBar,
          weekDay: lastSelTimeBar.weekday,
          calories: lastDataBar.last.calories);
    }
  }

  // create a list of items of type BarChartGroupData: a list of bars for the graphics
  Future makeItems() async {
    var lastDay = await db.selectedDao.findLastDayInDb();   // last time we inserted data
    items.clear();    // clear the list items from previous data
    DateTime date = statDate;   
    BarObj today = makeDay(date, lastDay!.dateTime);
    int day = today.weekDay;
    int sun = 7;
    // start day of the week
    DateTime startDay = date.subtract(Duration(days: (day)));

    // create bars from monday to day not included
    for (int i = 1; i < day; i++) {
      items.add(createItems(makeDay(startDay.add(Duration(days: i)), lastDay.dateTime)));

      // code for the normalization of the values of the bars
      BarObj obj = makeDay(startDay.add(Duration(days: i)), lastDay.dateTime);
      if (obj.calories > val_max) {
        val_max = obj.calories;
      }
    }

    // create bars from day included to sunday
    for (int j = 0; j <= (sun - day); j++) {
      items.add(createItems(makeDay(date.add(Duration(days: j)), lastDay.dateTime)));

      // code for the normalization of the values of the bars
      BarObj obj = makeDay(date.add(Duration(days: j)), lastDay.dateTime);
      if (obj.calories > val_max) {
        val_max = obj.calories;
      }
    }
  }

  // according to the day create the bars
  BarChartGroupData createItems(BarObj element) {
    if (element.weekDay == statDate.weekday) {
      return switchDays(element, true);
    } 
    else {
      return switchDays(element, false);
    }
  }

  // switch for draw in the correct day of the week
  switchDays(BarObj element, bool select) {
    switch (element.weekDay) {
      case 1:
        return makeGroupData(1, element.getCal(), select);
      case 2:
        return makeGroupData(2, element.getCal(), select);
      case 3:
        return makeGroupData(3, element.getCal(), select);
      case 4:
        return makeGroupData(4, element.getCal(), select);
      case 5:
        return makeGroupData(5, element.getCal(), select);
      case 6:
        return makeGroupData(6, element.getCal(), select);
      case 7:
        return makeGroupData(7, element.getCal(), select);
    }
  }

  // methods for drawing every single bar
  BarChartGroupData makeGroupData(int x, double y1, bool select) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: (select) 
            ? selDayBarColor
            : otherDaysBarColor,
          width: 7,
        ),
      ],
    );
  }

}
