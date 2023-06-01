import 'package:eaty_tourist/models/foods.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart';
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
    canvas.drawCircle(Offset(0, downBar), 5, _selectPaint(value, 0));
    //Ciclo for per disegnare i pallini della barra
    for (int i = 0; i < nfoods; i++) {
      canvas.drawCircle(Offset(0, downBar - foodList[i].calories/scale), 5, _selectPaint(value, i));
    }
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}