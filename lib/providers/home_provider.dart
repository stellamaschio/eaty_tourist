import 'dart:math';

import 'package:eaty_tourist/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:eaty_tourist/models/db.dart';
import 'package:eaty_tourist/models/entities/entities.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<HR> heartRates;
  late List<Calories> calories;
  final AppDatabase db;

  // data fetched from external services or db
  late List<HR> _heartRates;
  late List<Calories> _calories;

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
    var data = await db.heartRatesDao.findAllHeartRates();
    if (data.isEmpty) {
      return null;
    }
    return data.last.dateTime;
  }

  // method to fetch all data and calculate the exposure
  Future<void> _fetchAndCalculate() async {
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 2));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return;
    }

    _heartRates = await impactService.getDataHRFromDay(lastFetch);
    for (var element in _heartRates) {
      db.heartRatesDao.insertHeartRate(element);
    } // db add to the table

    _calories = await impactService.getDataCaloriesFromDay(lastFetch);
    for (var element in _calories) {
      db.caloriesDao.insertCalories(element);
    } // db add to the table

    _calculateCalories(_heartRates, _calories);
  }

  // method to trigger a new data fetching
  Future<void> refresh() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
  }

  // method that implements the state of the art formula
  void _calculateCalories(List<HR> hr, List<Calories> cal) {

    // da implementare
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
    heartRates = await db.heartRatesDao.findHeartRatesbyDate(
        DateUtils.dateOnly(showDate),   // operazioni standard data
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    calories = await db.caloriesDao.findCaloriesbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }
}
