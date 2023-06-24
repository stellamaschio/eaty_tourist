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

List<Food> foodList = ListFoods.foodList;

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
            color: Color(0xFF607D8B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(children: [
        SizedBox(
          height: 10,
        ),
        _listDesign(0, context),
        SizedBox(
          height: 10,
        ),
        _listDesign(1, context),
        SizedBox(
          height: 10,
        ),
        _listDesign(2, context),
        SizedBox(
          height: 10,
        ),
        _listDesign(3, context),
        SizedBox(
          height: 10,
        ),
        _listDesign(4, context),
        SizedBox(
          height: 10,
        ),
        _listDesign(5, context),
        SizedBox(
          height: 10,
        ),
        _listDesign(6, context),
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            SizedBox(width: 18,),
            Icon(
              MdiIcons.mapMarker,
              color: Color(0xFF929497),
            ),
            Text('City: Padua, Italy',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Color(0xFF929497),
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _listDesign(int i, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: ListTile(
        leading: Icon(
          foodList[i].icon,
          color: Color(0xFF607D8B),
          size: 30,
        ),
        title: Text(
          foodList[i].name,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Color(0xFF607D8B),
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

Widget _selectPage(int index) {
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
