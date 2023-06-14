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

  double totalCalories = 0;
  late double selectedCalories = 0;

  late double selectedSteps = 0;
  late double selectedDistance = 0;

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
    var data = await db.caloriesDao.findAllCalories();
    if (data.isEmpty) {
      return null;
    }
    return data.last.dateTime;
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

    steps = await db.stepsDao.findStepsbyTime(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

    distance = await db.distanceDao.findDistancebyTime(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    // after selecting all data we notify all consumers to rebuild
    totalCal();
    notifyListeners();
  }

  void totalCal(){
    double total = 0;
    for(var element in calories){
      total = total + element.value;
    }
    totalCalories = total;
  }

  void setSelectedCalories(double val){
    selectedCalories = val;
  }

  // utilizziamo come fosse oggi ma in realtà calories prende i dati di ieri
  void selectCalories(DateTime startTime, int i){
    int hour = startTime.hour;
    int minute = startTime.minute;
    int startMinute = hour*60 + minute;
    
    selectedCalories = selectedCalories + calories[startMinute+i].value;

  }

  void setTimeRange(DateTime startTime, DateTime endTime){
    int stHour = startTime.hour;
    int stMinute = startTime.minute;
    int startMinute = stHour*60 + stMinute;

    int edHour = startTime.hour;
    int edMinute = startTime.minute;
    int endMinute = stHour*60 + stMinute;

    for(int i=startMinute; i<=endMinute; i++){
      selectedSteps = selectedSteps + steps[startMinute+i].value;
      selectedDistance = selectedDistance + distance[startMinute+i].value;
    }
  }
  
}


