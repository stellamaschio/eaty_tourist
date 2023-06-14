import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Icecreams extends StatelessWidget {
  const Icecreams({super.key});

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
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(
                      'Icecreams',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF607D8B),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Restaurant name',
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
                    'Via ..',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Color(0xFF929497),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 5,),
                  Text(
                    'ciao come va io bene grazie',
                    style: GoogleFonts.montserrat(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
                  ]
                ),
              )
            ),
          )
    );
  }
}