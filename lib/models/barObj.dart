import 'package:flutter/material.dart';

class BarObj {

  //Costruttore
  const BarObj(
      {
        required this.dateTime,
        required this.weekDay,
        required this.calories,
      }
  );

  //Variabili della classe
  final DateTime dateTime;
  final int weekDay;
  final double calories;

  double getCal(){
    return calories;
  }

}