import 'package:eaty_tourist/models/restaurants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

class Foods {

  //Costruttore
  const Foods(
      {required this.name,
      required this.calories,
      required this.index,
      required this.icon,
      required this.description,
      required this.restaurants}
  );

  //Variabili della classe
  final String name;
  final double calories;
  final int index;
  final IconData icon;
  final String description;
  final List<Restaurants> restaurants;
  
  //Metodo per stampare le icone dei cibi
  Icon? printFoodIcon() {
    print(icon);
  }

  Widget printInfoFood(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '$name',
                style: GoogleFonts.montserrat(
                  color: Color(0xFF607D8B),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('$description',
                style: GoogleFonts.montserrat(
                  color: Color(0xFF607D8B),
                  fontSize: 18,
                  fontWeight: null,
                  decoration: null,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              printRestaurant(restaurants[0]),
              SizedBox(
                height: 15,
              ),
              printRestaurant(restaurants[1]),
            ]);
  }

  Widget printRestaurant(Restaurants rest) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(0xA969F0AF),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              color: Color.fromARGB(35, 0, 0, 0),
              blurRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${rest.name}',
            style: GoogleFonts.montserrat(
                color: Color(0xFF607D8B),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Icon(
                MdiIcons.mapMarker,
                color: Color(0xFF929497),
                size: 15,
              ),
              Text(
                '${rest.location}',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Color(0xFF929497),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Wrap(
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                '${rest.description}',
                style: GoogleFonts.montserrat(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}