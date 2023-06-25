import 'dart:math';
import 'package:eaty_tourist/models/barObj.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:eaty_tourist/models/db.dart';
import 'package:eaty_tourist/models/entities/entities.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<Calories> calories = [];
  late List<Steps> steps = [];
  late List<Distance> distance = [];

  late double selectedCalories = 0;
  late int selectedSteps = 0;
  late double selectedDistance = 0;
  late List<Selected> selectedByTime = [];
  late List<Selected> selectedUntilNow = [];
  late List<Selected> selectedAll = [];
  late List<Selected> temp = [];
  late List<Selected> lastData = [];


  late DateTime lastSelTime = dataLastTime;
  late DateTime dataLastTime;
  late DateTime dataFirstTime;

  late int firstDataDay;

  final AppDatabase db;

  // data fetched from external services or db
  late List<Calories> _calories;
  late List<Steps> _steps;
  late List<Distance> _distance;

  List<BarObj> cal_week = [];

  // selected day of data to be shown --> date of yesterday
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  // selected day of data to be shown --> date of yesterday
  // don't change usuing the application
  DateTime todayDate = DateTime.now().subtract(const Duration(days: 1));


  final ImpactService impactService;
  late DateTime lastFetch;

  bool doneInit = false;
  
  HomeProvider(this.impactService, this.db) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await dayLastTime(showDate);
    await lastTime();
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  Future<void> lastTime() async{
    dataLastTime = (await db.selectedDao.findLastDayInDb())!.dateTime;
  }

  Future<DateTime?> _getLastFetch() async {
    // sistemare
    var dataCal = await db.caloriesDao.findAllCalories();
    //var dataSteps = await db.stepsDao.findAllSteps();
    //var dataDist = await db.distanceDao.findAllDistance();
    if (dataCal.isEmpty /*|| dataSteps.isEmpty || dataDist.isEmpty*/) {
      return null;
    }
    return dataCal.last.dateTime;
  }

  // method to fetch all data
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
    } // db add to the table

    _steps = await impactService.getDataStepsFromDay(lastFetch);
    for (var element in _steps) {
      db.stepsDao.insertSteps(element);  
    } // db add to the table

    _distance = await impactService.getDataDistanceFromDay(lastFetch);
    for (var element in _distance) {
      db.distanceDao.insertDistance(element);    
    } // db add to the table
    
  }

  // method to trigger a new data fetching
  Future<void> refresh() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    // check if the day we want to show has data
    var firstDay = await db.caloriesDao.findFirstDayInDb();
    var lastDay = await db.caloriesDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateTime) ||
        showDate.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = showDate;

    // prendo solo perchè ho già filtrato nella query
    calories = await db.caloriesDao.findCaloriesbyTime(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

    notifyListeners();
  }

  void setSelected(double val){
    selectedCalories = val;
    selectedSteps = val.toInt();
    selectedDistance = val;
  }

  // utilizziamo come fosse oggi ma in realtà calories prende i dati di ieri
  void selectCalories(int startMinute, int minuteAdd){
    
    for(int i=1; i<=minuteAdd; i++){
      selectedCalories = selectedCalories + calories[startMinute+i].value;
    }

  }

  Future<void> setTimeRange(DateTime startTime, DateTime endTime) async{
    
    steps = await db.stepsDao.findStepsbyTime(startTime, endTime);
    distance = await db.distanceDao.findDistancebyTime(startTime, endTime);
    
    for(var element in steps){
      selectedSteps = selectedSteps + element.value;
    }

    for(var element in distance){
      selectedDistance = selectedDistance + element.value;
    }

  }
  
  // save calories, steps, and distance made during the day with the app
  Future<void> saveDay(DateTime time) async{
    DateTime startTime = DateTime(time.year, time.month, time.day, 00, 01);
    DateTime endTime = time;
    DateTime selTime = time;

    selectedUntilNow = await db.selectedDao.findSelectedbyTime(startTime, endTime);
    if(selectedUntilNow.isEmpty){
      selTime = time;
      // selectedCalories, selectedSteps, selectedDistance remain the same updated
      // by the methods selectCalories() and setTimeRange()
    }
    else{
      selTime = time;

      selectedCalories = selectedCalories + selectedUntilNow.last.calories;
      selectedSteps = selectedSteps + selectedUntilNow.last.steps;
      selectedDistance = selectedDistance + selectedUntilNow.last.distance;
    }
    
    await db.selectedDao.insertSelected(Selected(null, selectedCalories, selectedSteps, selectedDistance, selTime));
    selectedByTime = await db.selectedDao.findSelectedbyTime(startTime,endTime);

    lastSelTime = selTime;

    setSelected(0);
  }

  Future<void> getSelectedByTime(DateTime startTime, DateTime endTime, DateTime date) async{
    // check if the day we want to show has data
    var firstDay = await db.selectedDao.findFirstDayInDb();
    var lastDay = await db.selectedDao.findLastDayInDb();

    if (date.isAfter(lastDay!.dateTime) ||
          date.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = date;

    selectedByTime = await db.selectedDao.findSelectedbyTime(startTime,endTime);
    if(selectedByTime.isEmpty){
      await db.selectedDao.insertSelected(Selected(null, 0, 0, 0, showDate));
      selectedByTime = await db.selectedDao.findSelectedbyTime(startTime,endTime);
    }

    lastData.clear();
    lastData.add(selectedByTime.last);

    lastSelTime = selectedByTime.last.dateTime;

    notifyListeners();

  }

  Future<void> dayLastTime(DateTime time) async{
    selectAll();
    
    for(var element in selectedAll){
      if((element.dateTime.month == time.month) && (element.dateTime.day == (time.day))){
        temp.add(element);
      }
    }

    if(temp.isEmpty){
      return;
    }
    else{
      lastSelTime = temp.last.dateTime;
      lastData.clear();
      lastData.add(temp.last);
      Future.delayed(const Duration(microseconds: 1), () =>{
        temp = [],
      });
      
    }
  }

  void setShowDate(DateTime date){
    this.showDate = date;
  }

  Future<void> selectAll() async{
    selectedAll = await db.selectedDao.findAllSelected();
  }

  /*
  // add to the list cal_week a BarObj for every lastData of the day in db 
  // at every lastData is assigned the corrispective day of the week
  Future<void> makeWeekDay() async{
    firstDataTime = (await db.selectedDao.findFirstDayInDb())!.dateTime;
    Duration difference = todayDate.difference(firstDataTime);
    int diff = difference.inDays;

    for(int i=0; i<=diff; i++){
      dayLastTime(firstDataTime.add(Duration(days: i)));
      //cal_week.add(BarObj(dateTime: lastSelTime, weekDay: lastSelTime.weekday, calories: lastData.last.calories));
      
      Future.delayed(const Duration(seconds: 1), () => {
          cal_week.add(BarObj(dateTime: lastSelTime, weekDay: lastSelTime.weekday, calories: lastData.last.calories)),

        }
      );
      
      
    } 
  }*/

  BarObj makeDay(DateTime day) {
    /*
    if(day.isAfter(dataFirstTime)){
      
      return BarObj(dateTime: day.subtract(const Duration(days: 1)), 
                    weekDay: day.subtract(const Duration(days: 1)).weekday,
                    calories: 0);
    } 
    else if(day.isAfter(dataLastTime)){
      return BarObj(dateTime: day.add(const Duration(days: 1)), 
                    weekDay: day.add(const Duration(days: 1)).weekday,
                    calories: 0);
    } */
    if(day.isAfter(dataLastTime) && day.day == dataLastTime.day){
      dayLastTime(day);
      return BarObj(dateTime: lastSelTime, weekDay: lastSelTime.weekday, calories: lastData.last.calories);
    }
    else if(day.isAfter(dataLastTime)){
      dayLastTime(day);
      return BarObj(dateTime: day, weekDay: day.weekday, calories: 0);
    }
    else{
      dayLastTime(day);
      return BarObj(dateTime: lastSelTime, weekDay: lastSelTime.weekday, calories: lastData.last.calories);
    }
    
  }

  
  //methods for graphics

  final Color SelDayBarColor = Colors.pinkAccent.shade400;
  final Color OtherDaysBarColor = Color.fromARGB(255, 228, 139, 238);

  late List<BarChartGroupData> items = [];
  double rap_max = 0;
  double val_max = 1000;

  List<BarChartGroupData> makeItems(){
    items.clear();
    DateTime date = showDate;
    BarObj today = makeDay(date);
    int day = today.weekDay;
    int sun = 7;
    DateTime startDay = date.subtract(Duration(days: (day)));
    
    for(int i=1;i<day;i++){
      items.add(createItems(makeDay(startDay.add(Duration(days: i)))));
      
      // code for the normalization of the values of the bars
      BarObj obj = makeDay(startDay.add(Duration(days: i)));
      if(obj.calories > val_max){
        val_max = obj.calories;
      }
    }
    for(int j=0;j<=(sun-day);j++){
      items.add(createItems(makeDay(date.add(Duration(days: j)))));

      // code for the normalization of the values of the bars
      BarObj obj = makeDay(date.add(Duration(days: j)));
      if(obj.calories > val_max){
        val_max = obj.calories;
      }
    }
    return items;
  }

  BarChartGroupData createItems(BarObj element){
    if(element.weekDay == showDate.weekday){
      return switchSelDay(element);
    }
    else{
      return switchOtherDays(element);
    }
  }

  switchSelDay(BarObj element){
    switch(element.weekDay){
        case 1: 
          return makeGroupDataDay(1, element.getCal());          
        case 2:
          return makeGroupDataDay(2, element.getCal());
        case 3:
          return makeGroupDataDay(3, element.getCal());
        case 4:
          return makeGroupDataDay(4, element.getCal());
        case 5:
          return makeGroupDataDay(5, element.getCal());
        case 6:
          return makeGroupDataDay(6, element.getCal());
        case 7:
          return makeGroupDataDay(7, element.getCal());
        
      }
  }

  switchOtherDays(BarObj element){
    switch(element.weekDay){
        case 1: 
          return makeGroupData(1, element.getCal());          
        case 2:
          return makeGroupData(2, element.getCal());
        case 3:
          return makeGroupData(3, element.getCal());
        case 4:
          return makeGroupData(4, element.getCal());
        case 5:
          return makeGroupData(5, element.getCal());
        case 6:
          return makeGroupData(6, element.getCal());
        case 7:
          return makeGroupData(7, element.getCal());
        
      }
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: OtherDaysBarColor,
          width: 7,
        ),
      ],
    );
  }

  BarChartGroupData makeGroupDataDay(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: SelDayBarColor,
          width: 7,
        ),
      ],
    );
  }


}


