import 'package:eaty_tourist/models/foods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class Foodbar extends CustomPainter {

  //Costruttore della classe
  Foodbar(
      {required this.backColor,
      required this.frontColor,
      required this.lastColor,
      required this.strokeWidth,
      required this.upBar,
      required this.downBar,
      required this.scale,
      required this.foodList,
      required this.value,
      }
  );

  //Variabili della classe
  final Color backColor, frontColor, lastColor;
  final double strokeWidth, value, scale, upBar, downBar;
  final List<Foods> foodList;

  //Numero di cibi
  late int nfoods = foodList.length;

  //Tipi di Paint da usare nei canvas
  final uncompletedPaint = Paint();
  final completedPaint = Paint();
  final indicatorPaint = Paint();

  //Override del metodo paint (invocato sopra) che setta i valori delle paint
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    uncompletedPaint
      ..strokeWidth = strokeWidth
      ..color = backColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    completedPaint
      ..strokeWidth = strokeWidth
      ..color = frontColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    indicatorPaint
      ..strokeWidth = 10
      ..color = lastColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //Linee della barra non completata e completata
    canvas.drawLine(Offset(0, upBar), Offset(0, downBar), uncompletedPaint); //Gli argomenti sono coordinate partenza, fine, e paint
    canvas.drawLine(Offset(0, downBar), Offset(0, downBar - value/scale), completedPaint);

    //Pallino all'inizio della barra
    canvas.drawCircle(Offset(0, downBar), 5, _paintFirstDot(value));
    //Ciclo for per disegnare i pallini della barra
    for (int i = 0; i < nfoods; i++) {
      canvas.drawCircle(Offset(0, downBar - foodList[i].calories/scale), 5, _selectPaint(value, i));

      //Testo di ogni pallino
      final icon = foodList[i].icon;
      const double fontsize = 40;
      final textCal = foodList[i].calories.toInt();
      final food = foodList[i].name;

      //display food icons
      TextPainter iconPainter = TextPainter(textDirection: TextDirection.ltr);
      iconPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          color: _selectColor(value, i),
          fontSize: fontsize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage, // This line is mandatory for external icon packs
        ),
      );
      iconPainter.layout();
      iconPainter.paint(canvas, Offset(0 - 70, downBar - foodList[i].calories/scale - fontsize/2));

      //display text icon (calories)
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr,
        text: TextSpan(
            text: '$textCal cal',
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0 - 80, (downBar - foodList[i].calories/scale - fontsize/2)+40));
    
      // display food name
      TextPainter foodPainter = TextPainter(textDirection: TextDirection.ltr,
        text: TextSpan(
            text: food,
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
      );
      foodPainter.layout();
      foodPainter.paint(canvas, Offset(0 + 30, (downBar - foodList[i].calories/scale - fontsize/2)+10));
    
    }

    final IconData indicator = MdiIcons.arrowLeftThick;
    const double fsize = 40;

    //Indicatore del progresso attuale della barra
    canvas.drawCircle(Offset(0, downBar - value/scale), 0.5, indicatorPaint);

  }

  //Metodo per selzionare la giusta paint per i pallini degli obiettivi (foods)
  Paint _selectPaint(double value, int foodIndex) {
    if(value >= foodList[foodIndex].calories) {
      return completedPaint;
    }
    else {
      return uncompletedPaint;
    }
  }
   
  Paint _paintFirstDot(double value){
    if(value>0){
      return completedPaint;
    }
    else {
      return uncompletedPaint;
    }
  }

  //Metodo per selzionare la giusta paint per i pallini degli obiettivi (foods)
  Color _selectColor(double value, int foodIndex) {
    if(value >= foodList[foodIndex].calories) {
      return Color(0xFF607D8B);
    }
    else {
      return Color(0xA969F0AF);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}