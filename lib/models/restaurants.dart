import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

class Restaurants {

  //Costruttore
  const Restaurants(
      {required this.name,
      required this.location,
      required this.description}
  );

  //Variabili della classe
  final String name;
  final String location;
  final String description;
  
}