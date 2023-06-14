import 'package:eaty_tourist/models/foods.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListFoods {

  static const List<Foods> foodList = [
    Foods(name: 'APPLE', calories: 65, index: 1, icon: MdiIcons.foodApple),
    Foods(name: 'TOAST', calories: 150, index: 2, icon: MdiIcons.toaster),
    Foods(name: 'ICECREAM', calories: 247, index: 3, icon: MdiIcons.iceCream),
    Foods(name: 'PASTA', calories: 360, index: 4, icon: MdiIcons.pasta),
    Foods(name: 'CAKE', calories: 450, index: 5, icon: MdiIcons.cupcake),
    Foods(name: 'STEAK', calories: 630, index: 6, icon: MdiIcons.foodSteak),
    Foods(name: 'PIZZA', calories: 700, index: 7, icon: MdiIcons.pizza),
  ];
  
}