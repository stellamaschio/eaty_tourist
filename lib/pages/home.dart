import 'package:eaty_tourist/models/listFoods.dart';
import 'package:eaty_tourist/pages/info/info_apple.dart';
import 'package:eaty_tourist/pages/info/info_cake.dart';
import 'package:eaty_tourist/pages/info/info_icecreams.dart';
import 'package:eaty_tourist/pages/info/info_pasta.dart';
import 'package:eaty_tourist/pages/info/info_pizza.dart';
import 'package:eaty_tourist/pages/info/info_steak.dart';
import 'package:eaty_tourist/pages/info/info_toast.dart';
import 'package:eaty_tourist/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eaty_tourist/widgets/foodbar.dart';
import 'package:eaty_tourist/models/foods.dart';
import 'package:provider/provider.dart';

//Valore per provare il progresso della barra (max 200)
//const double calories = 360;
//int cal = calories.toInt();

//FoodBar dimension values
const double upBar = -40;
const double downBar = 490;

//List of Foods already initialized
List<Food> foodList = ListFoods.foodList;

//Scale to adjust the calories to the foodbar
double scale = foodList.last.calories / (downBar - upBar);

//Home
class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

//State of Home
class _HomeState extends State<Home> {

  //Booleans of the start, stop and demo buttons
  bool start = false;
  bool demo = false;
  bool close = false;

  //Number of times the demo button had been pressed
  int numberOfIncrements = 0;

  //Time Variables
  late DateTime StartTime = DateTime(0,0,0,0);
  late DateTime endTime = DateTime(0,0,0,0);
  late int startMinute;

  //Minute increment at every pression of Demo button
  final int minuteIncrement = 10;

  //Start Button State
  void _buttonStateStart(HomeProvider provider){
    setState(() {
      start = !start;
    });

    //We refer to yesterday data
    StartTime = DateTime.now().subtract(const Duration(days: 1));

    //Initialization of the date field of Day
    provider.day.setDayTime(StartTime);
    
    startMinute = StartTime.hour*60 + StartTime.minute;
  }

  //Demo Button State
  void _buttonStateDemo(HomeProvider provider){
    if(start){
      setState(() {
        demo = !demo;
      });

      //Update the Day calories
      provider.updateDayCalories(minuteIncrement, minuteIncrement);

      startMinute += minuteIncrement;   
      numberOfIncrements++;   
    }
  }

  //Stop Button State
  void _buttonStateClose(HomeProvider provider){
    if(!start && numberOfIncrements!=0){
      setState(() {
        close = !close;
      });

      //Update endTime, steps and Distance of day
      endTime = StartTime.add(Duration(minutes: (minuteIncrement*numberOfIncrements)));
      provider.updateDayDistance(StartTime, endTime);
      provider.updateDaySteps(StartTime, endTime);

      //Reset the bar and the increments counter
      provider.setSelected(0);
      numberOfIncrements = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Align(
            alignment: Alignment.center,
            child: Padding(
              // foodbar padding
              padding: EdgeInsets.fromLTRB(97, 100, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPaint(
                    painter: Foodbar(
                      backColor: Color(0xA969F0AF),
                      frontColor: Color(0xFF607D8B),
                      lastColor: Colors.white,
                      strokeWidth: 13,
                      upBar: upBar,
                      downBar: downBar,
                      scale: scale,
                      foodList: foodList,
                      value: provider.selectedCalories,
                    ),
                  ),
                  // info padding
                  Padding(
                    padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xA969F0AF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              //info column
                              Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Text(
                                    'Burned calories:',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${provider.day.calories.toInt()} cal',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey.shade600,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 25,),
                                  Text(
                                    'You unlocked',
                                    style: GoogleFonts.montserrat(
                                      color: Color(0xFF607D8B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  SizedBox(height: 3,),
                                  // unlocked food name
                                  Text(_foodUnlockedName(_foodUnlockedIndex(provider.day.calories, foodList),foodList),
                                    style: GoogleFonts.montserrat(
                                      color: _colorUnlocked(_foodUnlockedIndex(provider.day.calories, foodList), foodList, provider.selectedCalories),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //unlocked food button
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Color(0xFF607D8B),
                                        elevation: 6,
                                        backgroundColor: Colors.cyan.shade200,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.fromLTRB(25, 7, 25, 7),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => _selectPage(_foodUnlockedIndex(provider.day.calories, foodList)),
                                        ));
                                      },
                                      child: Icon(
                                        _foodUnlokedIcon(
                                          _foodUnlockedIndex(provider.day.calories, foodList),
                                          foodList),
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ),
                        //demo button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade500,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5),
                                ),
                                onPressed: () {
                                  _buttonStateDemo(provider);
                                },
                                child: Icon(MdiIcons.play, size: 35,)
                              ),
                              SizedBox(height: 5,),
                              Text('DEMO',
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF607D8B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //erase button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade500,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5),
                                ),
                                onPressed: () {
                                  _buttonStateClose(provider);
                                },
                                child: Icon(MdiIcons.close, size: 35,)
                              ),
                              SizedBox(height: 5,),
                              Text('CLOSE',
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF607D8B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // start botton padding
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.amberAccent.shade400,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                ),
                                onPressed: () {
                                  _buttonStateStart(provider);
                                },
                                child: (start)
                                  ? (Icon(MdiIcons.stop, size: 35,))
                                  : Icon(MdiIcons.runFast, size: 35,),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                (start)
                                ? '   STOP\nACTIVITY'
                                : '   START\nACTIVITY',
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF607D8B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }

  bool checkStart(bool start){
    return start;
  }

  int _foodUnlockedIndex(double value, List<Food> list){
    if(value<list.first.calories){
      // no unlocked food
      return -1;
    }
    // unlocked food!
    var result = list.takeWhile((x) => x.calories<=value);
    int index = result.last.index-1;
    return index;
  }

  IconData _foodUnlokedIcon(int index, List<Food> list){
    if(index<0){
      return MdiIcons.foodOff;
    }
    else{
      return list[index].icon;
    }
  }

  String _foodUnlockedName(int index, List<Food> list){
    if(index<0){
      return 'nothing';
    }
    else{
      String foodname = list[index].name;
      return '$foodname!';
    }
  }
  
  Color _colorUnlocked(int index, List<Food> list, double value){
    if(index<0){
      return Color(0xFF607D8B);
    }
    else if(value == foodList[index].calories){
      return Colors.yellowAccent;
    }
    else{
      return Color(0xFF607D8B); 
    }
  }

  Widget _selectPage(int index){
    switch (index) {
      case 0:
        return Apple();
      case 1:
        return Toast();
      case 2:
        return Icecreams();
      case 3:
        return Pasta();
      case 4:
        return Cake();
      case 5:
        return Steak();
      case 6:
        return Pizza();
      default:
        return Pizza();
    }
  }
}
