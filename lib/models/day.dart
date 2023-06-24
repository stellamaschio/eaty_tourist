import 'entities/calories.dart';
import 'entities/distance.dart';
import 'entities/steps.dart';

class Day {

  //Constructor
  Day({
    required this.date,
    required this.calories,
    required this.distance,
    required this.steps,
  });

  //Class Variables
  DateTime date;
  double calories;
  double distance;
  int steps;

  //Class Methods
  void setDayTime(DateTime newdate){
    date = newdate;
  }



}