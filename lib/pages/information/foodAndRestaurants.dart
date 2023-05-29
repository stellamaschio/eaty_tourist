import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodAndRestaurant extends StatelessWidget {
  const FoodAndRestaurant({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF607D8B),
        ),
        backgroundColor: const Color(0xA969F0AF),
        title: Text('Food and Restaurants',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: Color(0xFF607D8B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: ListTile(
              leading: Icon(
                MdiIcons.iceCream,
                color: Color(0xFF607D8B),
                size: 30,
              ),
              title: Text('Icecreams',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF607D8B),
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
          ),
        ]
      ),

    );
  }
}