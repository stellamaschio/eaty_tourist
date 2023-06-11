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
  final AppDatabase db;

  // data fetched from external services or db
  late List<Calories> _calories = [];

  // selected day of data to be shown --> date of yesterday
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  late DateTime startTime = showDate;
  late DateTime endTime = showDate.add(const Duration(minutes: 2));

  final ImpactService impactService;
  //late DateTime lastFetch;

  bool doneInit = false;
  
  HomeProvider(this.impactService, this.db) {
    calories.add(Calories(null, 0, showDate));
    _calories.add(Calories(null, 0.5, showDate));
  }

  // method to trigger a new data fetching
  Future<void> refresh() async {
    await _fetchAndCalculate();
    await getDataOfDay();
    _setTime();
  }

  // method to fetch all data and calculate the exposure
  Future<void> _fetchAndCalculate() async {
    _calories = await impactService.getDataCalories(startTime, endTime);
    for (var element in _calories) {
      db.caloriesDao.insertCalories(element);
    } // db add to the table
  }

  void _setTime(){
    startTime.add(const Duration(minutes: 1));
    endTime.add(const Duration(minutes: 1));
  }

  void state(bool start){
    start = !start;
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay() async {    
    // prendo solo perchè ho già filtrato nella query
    calories = await db.caloriesDao.findCaloriesbyTime(startTime, endTime);
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }
}
