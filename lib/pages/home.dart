import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eaty_tourist/widgets/foodbar.dart';

//Valore per provare il progresso della barra (max 200)
const double calories = 135;
//Numero di cibi che vogliamo mettere nella barra
const int nfoods = 6;

class Home extends StatelessWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body:  Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                height: 150,
                child: CustomPaint(
                  painter: foodbar(
                    backColor:  Color(0xA969F0AF),
                    frontColor:  Color(0xFF607D8B),
                    strokeWidth: 10,
                    value: calories,
                    nfoods: nfoods,
                  ),
                ),
              ),
        ),
    );
  }
}