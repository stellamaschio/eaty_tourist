import 'dart:math';

import 'package:eaty_tourist/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:eaty_tourist/models/db.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<HR> heartRates;
  late List<Calories> calories;

  // data fetched from external services or db
  late List<HR> _heartRatesDB;
  late List<Calories> _caloriesDB;

  // selected day of data to be shown --> date of yesterday
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  //tiene conto fin dove sono stati sincronizzati i dati
  // utile nel caso in cui scaricare nuovi dati da quel punto in poi
  DateTime lastFetch = DateTime.now().subtract(Duration(days: 2));
  final ImpactService impactService;

  bool doneInit = false;
  
  HomeProvider(this.impactService) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  // method to fetch all data and calculate
  Future<void> _fetchAndCalculate() async {
    _heartRatesDB = await impactService.getDataHRFromDay(lastFetch);
    _caloriesDB = await impactService.getDataCaloriesFromDay(lastFetch);
    // da sistemare
    _calculateCalories(_heartRatesDB, _caloriesDB);  
  }


  // method to trigger a new data fetching
  void refresh() {
    _fetchAndCalculate();
    getDataOfDay(showDate);
  }

  // method that implements the state of the art formula
  void _calculateCalories(List<HR> hr, List<Calories> cal) {

    // da implementare
   }

  // method to select only the data of the chosen day
  void getDataOfDay(DateTime showDate) {
    this.showDate = showDate;
    heartRates = _heartRatesDB
        .where((element) => element.timestamp.day == showDate.day)
        .toList()
        .reversed
        .toList();
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }
}
