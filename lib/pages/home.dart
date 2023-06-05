import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eaty_tourist/widgets/foodbar.dart';
import 'package:eaty_tourist/models/foods.dart';

//Valore per provare il progresso della barra (max 200)
const double calories = 199;
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(115, 100, 0, 0),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
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
                          Column(
                            children: [
                              Text(
                                '$cal cal',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade600,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$cal cal',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade600,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 480, 0, 0),
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(18),
                        ),
                        onPressed: () {},
                        child: Icon(
                          MdiIcons.runFast,
                          size: 35,
                          ),
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
}
