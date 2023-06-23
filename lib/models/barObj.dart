import 'package:flutter/material.dart';

class BarObj {

  //Costruttore
  const BarObj(
      {
        required this.day,
        required this.numb,
        required this.calories,
      }
  );

  //Variabili della classe
  final String day;
  final int numb;
  final double calories;

  double getCal(){
    return calories;
  }

}