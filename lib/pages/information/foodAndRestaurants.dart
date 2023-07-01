import 'package:eaty_tourist/models/foods.dart';
import 'package:eaty_tourist/models/listFoods.dart';
import 'package:eaty_tourist/pages/info/info_apple.dart';
import 'package:eaty_tourist/pages/info/info_cake.dart';
import 'package:eaty_tourist/pages/info/info_icecreams.dart';
import 'package:eaty_tourist/pages/info/info_pasta.dart';
import 'package:eaty_tourist/pages/info/info_pizza.dart';
import 'package:eaty_tourist/pages/info/info_steak.dart';
import 'package:eaty_tourist/pages/info/info_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


//this class create a ListView for every food 
// when you clic the list you can see the info for the selected food 
// these info are printed by the widget in the info_food pages

List<Foods> foodList = ListFoods.foodList;

class FoodAndRestaurant extends StatelessWidget {
  const FoodAndRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF607D8B),
        ),
        backgroundColor: const Color(0xA969F0AF),
        title: Text(
          'Food and Restaurants',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: const Color(0xFF607D8B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 10,
        ),
        _listDesign(0, context),
        const SizedBox(
          height: 10,
        ),
        _listDesign(1, context),
        const SizedBox(
          height: 10,
        ),
        _listDesign(2, context),
        const SizedBox(
          height: 10,
        ),
        _listDesign(3, context),
        const SizedBox(
          height: 10,
        ),
        _listDesign(4, context),
        const SizedBox(
          height: 10,
        ),
        _listDesign(5, context),
        const SizedBox(
          height: 10,
        ),
        _listDesign(6, context),
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            const SizedBox(width: 18,),
            const Icon(
              MdiIcons.mapMarker,
              color: Color(0xFF929497),
            ),
            Text('City: Padua, Italy',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: const Color(0xFF929497),
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  // this method print a ListView object for the selected food
  Widget _listDesign(int i, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: ListTile(
        leading: Icon(
          foodList[i].icon,
          color: const Color(0xFF607D8B),
          size: 30,
        ),
        title: Text(
          foodList[i].name,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF607D8B),
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _selectPage(i),
          ));
        },
      ),
    );
  }
}

// this method select the info page for every food
Widget _selectPage(int index) {
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
