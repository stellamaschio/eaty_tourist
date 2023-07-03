//class for the object of the bars in statistics page

class BarObj {

  //Constructor
  const BarObj(
      {
        required this.dateTime,
        required this.weekDay,
        required this.calories,
      }
  );

  //Variables
  final DateTime dateTime;
  final int weekDay;
  final double calories;

  double getCal(){
    return calories;
  }

}