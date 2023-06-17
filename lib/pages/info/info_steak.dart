import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Steak extends StatelessWidget {
  const Steak({super.key});

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
                      'Steak',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF607D8B),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      "A steak is a cut of meat, usually from animals such as cattle, pigs or lambs. It is a thick slice of meat that is usually cooked on a grill, griddle, or skillet. Steak has a juicy texture and can vary depending on the cut of meat and the degree of cooking desired. Some popular cuts of steak include filet, rib eye, and sirloin. Each cut has its own specific characteristics in terms of tenderness, flavor and presence of fat. Steak can be seasoned with salt, pepper or other spices to enhance the natural flavor of the meat. It is served as a second course, accompanied by side dishes such as potatoes, vegetables, salad or sauce. Steak is prized for its juicy texture and intense flavor and is often associated with hearty and tasty meals.",
                      /*"Una bistecca è un taglio di carne, di solito proveniente da animali come bovini, maiali o agnelli. È una fetta spessa di carne che viene solitamente cucinata alla griglia, alla piastra o in padella."
                      "La bistecca ha una consistenza succosa e può variare in base al taglio della carne e al grado di cottura desiderato. Alcuni tagli di bistecca popolari includono il filetto, la costata e la controfiletto. Ogni taglio ha le sue caratteristiche specifiche in termini di tenerezza, sapore e presenza di grasso."
                      "La bistecca può essere condita con sale, pepe o altre spezie per esaltare il sapore naturale della carne. Viene servita come secondo, accompagnata da contorni come patate, verdure, insalata o salsa."
                      "La bistecca è apprezzata per la sua consistenza succosa e sapore intenso e viene spesso associata a pasti abbondanti e gustosi.",
                      */
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
              Container(
                decoration: const BoxDecoration(color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [BoxShadow(offset: Offset(0, 12),
                    color: Color.fromARGB(35, 0, 0, 0),
                    blurRadius: 2)],
                  ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      'Osteria L\'Anfora',
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
                    'Via Soncin, 13, 35121 Padova PD',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Color(0xFF929497),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Wrap(
                children: [
                  SizedBox(width: 5,),
                  Text(
                    'Simple and cozy Osteria, where you can enjoy good meals and relax with friends. In the historic center of Padua, near Piazza dei Signori.',
                    style: GoogleFonts.montserrat(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [BoxShadow(offset: Offset(0, 12),
                    color: Color.fromARGB(35, 0, 0, 0),
                    blurRadius: 2)],
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vecchia Padova',
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
                    'Via Cesare Battisti, 37, 35121 Padova PD',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Color(0xFF929497),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Wrap(
                children: [
                  SizedBox(width: 5,),
                  Text(
                    'Historic trattoria with tasty and genuine dishes, with excellent interior decor. The dishes are all typical of the Veneto tradition.',
                    style: GoogleFonts.montserrat(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                    ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          )),
        ));
  }
}