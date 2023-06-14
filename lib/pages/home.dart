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

//Valori dipartenza e fine delle linee
//NOTA: Widget all'interno di una sized box definita in home
const double upBar = -40;
const double downBar = 490;

List<Foods> foodList = ListFoods.foodList;

double scale = foodList.last.calories / (downBar - upBar);

class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool start = false;
  late DateTime time = DateTime(0,0,0,0);

  //start is true because we are ready to start
  void _buttonState(){
    setState(() {
      start = !start;
    });
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
                                    '${provider.selectedCalories.toInt()} cal',
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
                                  Text(_foodUnlockedName(_foodUnlockedIndex(provider.selectedCalories, foodList),foodList),
                                    style: GoogleFonts.montserrat(
                                      color: _colorUnlocked(_foodUnlockedIndex(provider.selectedCalories, foodList), foodList, provider.selectedCalories),
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
                                          builder: (context) => _selectPage(_foodUnlockedIndex(provider.selectedCalories, foodList)),
                                        ));
                                      },
                                      child: Icon(
                                        _foodUnlokedIcon(
                                          _foodUnlockedIndex(provider.selectedCalories, foodList),
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
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade500,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5),
                                ),
                                onPressed: () {
                                  if(start){
                                    // utilizziamo come fosse oggi ma in realtà calories prende i dati di ieri
                                  // qui interessano solo ora e minuto
                                  provider.selectCalories(time);
                                  time.add(Duration(minutes: 10));
                                  }
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
                        // start botton padding
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.amberAccent.shade400,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                ),
                                onPressed: () {
                                  _buttonState();
                                  time = DateTime.now();
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

  /*
  void switchAction(bool start, HomeProvider prov){
    DateTime time = DateTime.now();
    while(start){
      // utilizziamo come fosse oggi ma in realtà calories prende i dati di ieri
      // qui interessano solo ora e minuto
      prov.selectCalories(time);
      time.add(Duration(minutes: 10));
    }
  }
  */

  int _foodUnlockedIndex(double value, List<Foods> list){
    if(value<list.first.calories){
      // no unlocked food
      return -1;
    }
    // unlocked food!
    var result = list.takeWhile((x) => x.calories<=value);
    int index = result.last.index-1;
    return index;
  }

  IconData _foodUnlokedIcon(int index, List<Foods> list){
    if(index<0){
      return MdiIcons.foodOff;
    }
    else{
      return list[index].icon;
    }
  }

  String _foodUnlockedName(int index, List<Foods> list){
    if(index<0){
      return 'nothing';
    }
    else{
      String foodname = list[index].name;
      return '$foodname!';
    }
  }
  
  Color _colorUnlocked(int index, List<Foods> list, double value){
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
