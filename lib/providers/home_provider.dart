import 'dart:math';

import 'package:eaty_tourist/services/impact.dart';
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
  late List<Selected> selectedAll;
  late List<Selected> selectedByTime;

  late Selected data = Selected(null, 0, 0, 0, showDate);

  final AppDatabase db;

  // data fetched from external services or db
  late List<Calories> _calories;
  late List<Steps> _steps;
  late List<Distance> _distance;

  // selected day of data to be shown --> date of yesterday
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  final ImpactService impactService;
  late DateTime lastFetch;

  bool doneInit = false;
  
  HomeProvider(this.impactService, this.db) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
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
  void selectCalories(int startMinute){
    
    for(int i=1; i<=10; i++){
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
  void saveDay(){
    db.selectedDao.insertSelected(Selected(null, selectedCalories, selectedSteps, selectedDistance, showDate));
    setSelected(0);
  }

  Future<void> getSelectedByTime(DateTime startTime, DateTime endTime, DateTime date) async{
    // check if the day we want to show has data
    var firstDay = await db.selectedDao.findFirstDayInDb();
    var lastDay = await db.selectedDao.findLastDayInDb();

    if (date.isAfter(lastDay!.dateTime) ||
        date.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = date;

    late double cal = 0;
    late int st = 0;
    late double dist = 0;

    selectedByTime = await db.selectedDao.findSelectedbyTime(startTime,endTime);

    for(var element in selectedByTime){
      cal = cal + element.calories;
      st = st + element.steps;
      dist = dist +element.distance;
    }
    data = Selected(null, cal, st, dist, date);
    
    notifyListeners();
  }

  void setShowDate(DateTime date){
    this.showDate = date;
  }
}


