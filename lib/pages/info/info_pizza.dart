import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Pizza extends StatelessWidget {
  const Pizza({super.key});

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
                      'Pizza',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF607D8B),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      "Pizza is a dish originating in Italy, consisting of a leavened dough base, called dough, which is rolled out in a circular shape. The dough is usually made with flour, water, yeast and salt. The pizza base is then topped with a tomato sauce and covered with a variety of ingredients such as cheese (usually mozzarella), cold cuts, vegetables, mushrooms, seafood, and other additions as desired. Once the pizza has been topped, it is baked in a hot oven until the dough becomes golden brown and crispy. The result is a warm, fragrant pizza with a thin or thicker base, depending on the style preferred. Pizza is a popular and beloved dish all over the world. It can be eaten as a main meal, often shared among friends or family. It is a versatile dish, as there are many types of pizzas with different flavors, allowing it to satisfy a wide range of culinary preferences.",
                      /*"La pizza è un piatto originario dell'Italia, composto da una base di pasta lievitata, chiamata impasto, che viene stesa in forma circolare. L'impasto è solitamente fatto con farina, acqua, lievito e sale. La base della pizza viene poi condita con una salsa di pomodoro e coperta con una varietà di ingredienti come formaggio (di solito mozzarella), salumi, verdure, funghi, frutti di mare e altre aggiunte a piacere."
                      "Una volta che la pizza è stata condita, viene cotta in un forno caldo fino a quando l'impasto diventa dorato e croccante. Il risultato è una pizza calda e fragrante, con una base sottile o più spessa, a seconda dello stile preferito."
                      "La pizza è un piatto molto popolare e amato in tutto il mondo. Può essere consumata come pasto principale, spesso condivisa tra amici o familiari. È un piatto versatile, poiché ci sono molti tipi di pizze con gusti diversi, consentendo di soddisfare una vasta gamma di preferenze culinarie.",
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
                      'Marechiaro Ristorante Pizzeria',
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
                    'Via Daniele Manin, 37, 35122 Padova PD',
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
                    'Pizzeria restaurant, also with outdoor seating in a pretty little courtyard surrounded by historic houses, a stone\'s throw from Piazza dei Signori. Great reviews for pasta and pizza!',
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
                      'Forbici Pizza',
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
                    'Via S. Francesco, 28, 35123 Padova PD',
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
                    'Popular and well-reviewed establishment, for lovers of high dough pizza!',
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