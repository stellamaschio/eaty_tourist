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
                      "Ice cream is a cold, creamy dessert that is made with ingredients such as milk, sugar and various flavorings. There are many different flavors of ice cream, such as chocolate, vanilla, strawberry, mint and many others. In addition, ice cream can be enriched by adding fruit, chocolate, nuts or other ingredients to give more variety of flavors. Ice cream is generally served in a cup or on a cone and is very popular during hot days. It is a dessert loved by people of all ages.",
                      /*"Il gelato è un dessert freddo e cremoso che viene preparato con ingredienti come latte, zucchero e aromi vari."
                      "Ci sono molti gusti diversi di gelato, come cioccolato, vaniglia, fragola, menta e molti altri. Inoltre, il gelato può essere arricchito con aggiunta di frutta, cioccolato, noci o altri ingredienti per dare più varietà di sapori."
                      "Il gelato viene servito generalmente in una coppetta o su un cono, è molto popolare durante i giorni caldi. È un dolce amato da persone di tutte le età.",
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
                      'Venchi Cioccolato e Gelato',
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
                    'Via Roma, 1, 35122 Padova PD',
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
                    'Famous chain of ice cream shops, very popular and appreciated. In the historic center of Padua.',
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
                      'GROM',
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
                    'Piazza dei Signori, 33, 35139 Padova PD',
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
                    'Famous chain of ice cream shops, known for using natural products to make ice cream. Located in Piazza dei Signori, ideal for getting an ice cream while enjoying the square.',
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
