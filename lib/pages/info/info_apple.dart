import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Apple extends StatelessWidget {
  const Apple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF607D8B),
          ),
          backgroundColor: const Color(0xA969F0AF),
          title: Text(
            'Food and Restaurants',
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
            child:Column(crossAxisAlignment: 
                CrossAxisAlignment.start, children: [
              Text(
                'Apple',
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
              Text(
                "The apple is a round fruit and can come in different colors, such as red, green or yellow. The skin of the apple is smooth and can be shiny. Inside, it has crisp and juicy flesh with a sweet and slightly pungent, sour taste. They are often eaten as a snack or used to make juices, pies, jams and other recipes. Apples are a good source of vitamins and fiber, which are important for the health of our bodies.",
                /*
                "La mela è un frutto di forma rotonda e può essere di diversi colori, come rosso, verde o giallo. "
                "La pelle della mela è liscia e può essere lucida. All\'interno, ha una polpa "
                "croccante e succosa, dal sapore dolce e leggermente pungente, aspro.\nSono spesso consumate "
                "come spuntino o utilizzate per preparare succhi di frutta, torte, marmellate e altre ricette. "
                "Le mele sono una buona fonte di vitamine e fibre, importanti per la salute del nostro corpo.",
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
                        'Sotto il Salone',
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
                            'Piazza delle Erbe, 35, 35122 Padova PD',
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
                            'Small grocery store under the colonnade of Padua\'s Palazzo della Ragione in Piazza delle Erbe.',
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
                      'Despar',
                      style: GoogleFonts.montserrat(
                          color: Color(0xFF607D8B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        const Icon(
                          MdiIcons.mapMarker,
                          color: Color(0xFF929497),
                          size: 15,
                        ),
                        Text(
                          'Via Stefano Breda, 16, 35139 Padova PD',
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
                          'Despar supermarket in the historic center of Padua.',
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
