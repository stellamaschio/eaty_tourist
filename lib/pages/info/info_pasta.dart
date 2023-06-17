import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Pasta extends StatelessWidget {
  const Pasta({super.key});

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
                      'Pasta',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF607D8B),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      "Pasta is a food made from flour and water, which is kneaded to create a solid mass. Pasta can come in different shapes, such as spaghetti, penne, fusilli, linguine, and many other types. It is cooked by soaking it in boiling water until tender or more \"al dente\". Pasta is a very versatile food and can be combined with a variety of sauces, such as tomato sauce, pesto, ragù, carbonara, and more. It can also be used as a base for cold dishes, such as pasta salads. Pasta is a staple of Italian cuisine. It is nutritious, rich in carbohydrates and can be enriched with ingredients such as vegetables, meat, fish or cheese to create tasty and satisfying dishes.",
                      /*"La pasta è un alimento a base di farina e acqua, che viene impastato per creare una massa solida. La pasta può avere forme diverse, come spaghetti, penne, fusilli, linguine e molti altri tipi. Viene cucinata immergendola in acqua bollente fino a diventare tenera o più al dente."
                      "La pasta è un alimento molto versatile e può essere abbinata a una varietà di salse, come salsa di pomodoro, pesto, ragù, carbonara e tanto altro. Può anche essere utilizzata come base per piatti freddi, come insalate di pasta."
                      "La pasta è un alimento fondamentale della cucina italiana. È nutriente, ricca di carboidrati e può essere arricchita con ingredienti come verdure, carne, pesce o formaggio per creare piatti gustosi e soddisfacenti.",
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
            ]),
          )),
        ));
  }
}