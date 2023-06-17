import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Toast extends StatelessWidget {
  const Toast({super.key});

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
                      'Toast',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF607D8B),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      "A toast (or \"tost\" in Italian) is a toasted or toasted slice of bread. It is prepared by passing the bread through a heat source, such as a toaster or oven, until it becomes crisp and golden brown. Toast can be eaten simply as it is but is most often stuffed with sottiletta and ham. It is often served for breakfast or daily snacks. Toast is a common and widely appreciated food because of its simplicity and versatility. Its quick preparation and tasty nature make it a popular choice for a quick meal or snack.",
                      /*"Un toast (o \"tost\" in italiano) è una fetta di pane tostata o abbrustolita. Viene preparato passando il pane attraverso una fonte di calore, come una tostapane o un forno, fino a quando diventa croccante e dorato."
                      "Il toast può essere consumato semplicemente così com'è ma viene più spesso farcito con sottiletta e prosciutto. Viene spesso servito a colazione o per spuntini giornalieri."
                      "Il toast è un alimento comune e ampiamente apprezzato per la sua semplicità e versatilità. La sua preparazione rapida e la sua natura gustosa lo rendono una scelta popolare per un pasto veloce o uno spuntino.",
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
                'Bar Margherita',
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
                    'Piazza della Frutta, 44, 35122 Padova PD',
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
                    'Bar with outdoor and indoor tables, overlooking Piazza dei Signori with excellent views of the Palazzo della Ragione. The walls have large windows to enjoy the view of the square even from inside.',
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
                'Bar Tre Scalini',
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
                    'Via Venezia, 2, 35131 Padova PD',
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
                    'A bar in the university area of Padua, it overlooks Porta Portello, an area convenient to students, with the presence of a beautiful historic avenue: Via del Portello. It is frequented by hundreds of students every day, space is abundant, especially outside. The presnce of the river moves the buildings away from the esplanade and allows the eye to wander, a relaxing feeling to many.',
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
