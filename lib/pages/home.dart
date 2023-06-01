import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eaty_tourist/widgets/foodbar.dart';
import 'package:eaty_tourist/models/foods.dart';

//Valore per provare il progresso della barra (max 200)
const double calories = 500;

//Valori dipartenza e fine delle linee
//NOTA: Widget all'interno di una sized box definita in home
const double upBar = 0;
const double downBar = 600;
double scale = foodList.last.calories / (downBar-upBar);

//Lista dei Foods
final List<Foods> foodList = [
  const Foods(name: 'CRACKERS', calories: 130, index: 1, icon: MdiIcons.baguette),
  const Foods(name: 'PASTA', calories: 400, index: 2, icon: MdiIcons.pasta),
  const Foods(name: 'PIZZA', calories: 700, index: 3, icon: MdiIcons.pizza),
];

class Home extends StatelessWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 200,
          height: 600,
          child: CustomPaint(
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
        ),
      ),
    );
  }
}
