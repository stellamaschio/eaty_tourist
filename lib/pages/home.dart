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

// this class displays the food bar

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
  bool demo = false;
  bool close = false;
  int index = 0;
  late DateTime time = DateTime(0,0,0,0);
  late DateTime startTime = DateTime(0,0,0,0);
  late DateTime endTime = DateTime(0,0,0,0);
  late int startMinute;
  final int minuteAdd = 10;

  @override
  void initState() {
    super.initState();
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);

    // set the date of Statistics page to the date of today
    provider.setStatDate(provider.todayDate);
  }

  // start activity button
  void _buttonState(HomeProvider provider){
    setState(() {
      start = !start;
    });
    // set the time
    time = DateTime.now().subtract(const Duration(days: 1));
    provider.setShowDate(time);    

    // calculate the minutes
    //used for check if there is enough data and for select the correct data
    startMinute = _dateTime2Minute(time);   
    startTime = time;
    endTime = time.add(Duration(minutes: minuteAdd));
  }

  // demo button
  void _buttonStateDemo(HomeProvider provider, BuildContext context){
    // it works only if buttonState is true (activity started)
    if(start){
      setState(() {
        demo = !demo;
      });
      // selecte the data 
      provider.selectCalories(startMinute, minuteAdd, startTime, endTime, context);
      startMinute = startMinute + minuteAdd;
      startTime = startTime.add(Duration(minutes: minuteAdd));
      endTime = endTime.add(Duration(minutes: minuteAdd));
      index++;
    }
  }

  // save button 
  void _buttonStateClose(HomeProvider provider){
    // works only if there is selected data and the buttonState is false (activity stopped)
    if(!start && index!=0){
      setState(() {
        close = !close;
      });
      // save the data
      provider.saveDay(time);
      index = 0;
      //save the date of the page for statistics
      provider.setStatDate(provider.showDate);
    }
  }

  // calculate minutes from the beginning of the day
  int _dateTime2Minute(DateTime t){
    return t.hour*60 + t.minute;
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
              padding: const EdgeInsets.fromLTRB(97, 100, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPaint(
                    painter: Foodbar(
                      backColor: const Color(0xA969F0AF),
                      frontColor: const Color(0xFF607D8B),
                      lastColor: Colors.white,
                      strokeWidth: 13,
                      upBar: upBar,
                      downBar: downBar,
                      scale: scale,
                      foodList: foodList,
                      value: provider.selCal,
                    ),
                  ),
                  // info padding
                  Padding(
                    padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xA969F0AF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10,),
                              //info column
                              Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  Text(
                                    'Burned calories:',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${provider.selCal.toInt()} cal',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey.shade600,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 25,),
                                  Text(
                                    'You unlocked',
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xFF607D8B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const SizedBox(height: 3,),
                                  // unlocked food name
                                  Text(_foodUnlockedName(_foodUnlockedIndex(provider.selCal, foodList),foodList),
                                    style: GoogleFonts.montserrat(
                                      color: _colorUnlocked(_foodUnlockedIndex(provider.selCal, foodList), foodList, provider.selCal),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //unlocked food button
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: const Color(0xFF607D8B),
                                        elevation: 6,
                                        backgroundColor: Colors.cyan.shade200,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(25, 7, 25, 7),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => _selectPage(_foodUnlockedIndex(provider.selCal, foodList)),
                                        ));
                                      },
                                      child: Icon(
                                        _foodUnlokedIcon(
                                          _foodUnlockedIndex(provider.selCal, foodList),
                                          foodList),
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                              const SizedBox(width: 10,),
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
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                ),
                                onPressed: () {
                                  _buttonStateDemo(provider, context);
                                },
                                child: const Icon(MdiIcons.play, size: 35,)
                              ),
                              const SizedBox(height: 5,),
                              Text('DEMO',
                                style: GoogleFonts.montserrat(
                                  color: const  Color(0xFF607D8B),
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
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                ),
                                onPressed: () {
                                  _buttonStateClose(provider);
                                },
                                child: const Icon(MdiIcons.check, size: 35,)
                              ),
                              const SizedBox(height: 5,),
                              Text('SAVE',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFF607D8B),
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
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(15),
                                ),
                                onPressed: () {
                                  _buttonState(provider);
                                },
                                child: (start)
                                  ? (const Icon(MdiIcons.stop, size: 35,))
                                  : const Icon(MdiIcons.runFast, size: 35,),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                (start)
                                ? '   STOP\nACTIVITY'
                                : '   START\nACTIVITY',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFF607D8B),
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

  // get the index of the unlocked food
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
  
  // get the icon of the unlocked food
  IconData _foodUnlokedIcon(int index, List<Foods> list){
    if(index<0){
      return MdiIcons.foodOff;
    }
    else{
      return list[index].icon;
    }
  }

  // get the name of the unlocked food
  String _foodUnlockedName(int index, List<Foods> list){
    if(index<0){
      return 'nothing';
    }
    else{
      String foodname = list[index].name;
      return '$foodname!';
    }
  }
  
  // set the color for locked and unlocked foods
  Color _colorUnlocked(int index, List<Foods> list, double value){
    if(index<0){
      return const Color(0xFF607D8B);
    }
    else if(value == foodList[index].calories){
      return Colors.yellowAccent;
    }
    else{
      return const Color(0xFF607D8B); 
    }
  }

  // select food page
  Widget _selectPage(int index){
    switch (index) {
      case 0:
        return const Apple();
      case 1:
        return const Toast();
      case 2:
        return const Icecreams();
      case 3:
        return const Pasta();
      case 4:
        return const Cake();
      case 5:
        return const Steak();
      case 6:
        return const Pizza();
      default:
        return const Pizza();
    }
  }
}
