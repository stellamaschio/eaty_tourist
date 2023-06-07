import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eaty_tourist/widgets/foodbar.dart';
import 'package:eaty_tourist/models/foods.dart';

//Valore per provare il progresso della barra (max 200)
const double calories = 300;
int cal = calories.toInt();

//Valori dipartenza e fine delle linee
//NOTA: Widget all'interno di una sized box definita in home
const double upBar = -25;
const double downBar = 625;
double scale = foodList.last.calories / (downBar - upBar);

//Lista dei Foods
final List<Foods> foodList = [
  const Foods(name: 'APPLE', calories: 65, index: 1, icon: MdiIcons.foodApple),
  const Foods(name: 'TOAST', calories: 150, index: 2, icon: MdiIcons.toaster),
  const Foods(name: 'ICECREAM', calories: 247, index: 3, icon: MdiIcons.iceCream),
  const Foods(name: 'PASTA', calories: 360, index: 4, icon: MdiIcons.pasta),
  const Foods(name: 'CAKE', calories: 450, index: 5, icon: MdiIcons.cupcake),
  const Foods(name: 'STEAK', calories: 630, index: 6, icon: MdiIcons.foodSteak),
  const Foods(name: 'PIZZA', calories: 700, index: 7, icon: MdiIcons.pizza),
];

class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //start is true because we are ready to start
  bool start = true;

  void _buttonState(){
    setState(() {
      start = !start;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          // foodbar padding
          padding: EdgeInsets.fromLTRB(110, 100, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPaint(
                painter: Foodbar(
                  backColor: Color(0xA969F0AF),
                  frontColor: Color(0xFF607D8B),
                  lastColor: Colors.white,
                  strokeWidth: 15,
                  upBar: upBar,
                  downBar: downBar,
                  scale: scale,
                  foodList: foodList,
                  value: calories,
                ),
              ),
              // info padding
              Padding(
                padding: const EdgeInsets.fromLTRB(110, 0, 0, 0),
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                '$cal cal',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade600,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Text(
                                'You unlocked',
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF607D8B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(height: 5,),
                              // unlocked food name
                              Text(_foodUnlockedName(_foodUnlockedIndex(calories, foodList),foodList),
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF607D8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //unlocked food button
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Color(0xFF607D8B),
                                    elevation: 6,
                                    backgroundColor: Colors.cyan.shade200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  ),
                                  onPressed: () {
                                    /*
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InfoPollutants(),
                                    ));*/
                                  },
                                  child: Icon(
                                    _foodUnlokedIcon(
                                      _foodUnlockedIndex(calories, foodList),foodList),
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
                    // start botton padding
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 270, 0, 0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.amberAccent.shade400,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(18),
                            ),
                            onPressed: () {
                              _buttonState();
                            },
                            child: (start)
                              ? Icon(MdiIcons.runFast, size: 35,)
                              : Icon(MdiIcons.stop, size: 35,),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            (start)
                            ? '   START\nACTIVITY'
                            : '   STOP\nACTIVITY',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF607D8B),
                              fontSize: 18,
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
    );
  }

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
}
