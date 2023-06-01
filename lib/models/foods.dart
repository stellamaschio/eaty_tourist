import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

class Foods {

  //Costruttore
  const Foods(
      {required this.name,
      required this.calories,
      required this.index,
      required this.icon,}
  );

  //Variabili della classe
  final String name;
  final double calories;
  final int index;
  final IconData icon;
  
  //Metodo per stampare le icone dei cibi
  Icon? printFoodIcon() {
    print(icon);
  }

}