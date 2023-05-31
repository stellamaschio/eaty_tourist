import 'package:eaty_tourist/models/foods.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart';

class Foodbar extends CustomPainter {

  //Costruttore della classe
  Foodbar(
      {required this.backColor,
      required this.frontColor,
      required this.lastColor,
      required this.strokeWidth,
      required this.value,
      });

  //Variabili della classe
  final Color backColor, frontColor, lastColor;
  final double strokeWidth, value;

  //Lista dei Foods
  final List<Foods> foodList = [
    const Foods(name: 'crackers', calories: 130, index: 1),
    const Foods(name: 'pasta', calories: 400, index: 2),
    const Foods(name: 'pizza', calories: 700, index: 3),
  ];

  //Numero di cibi
  late int nfoods = foodList.length;

  final uncompletedPaint = Paint();
  final completedPaint = Paint();
  final lastPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    //Valori dipartenza e fine delle linee
    //NOTA: Widget all'interno di una sized box centrata e larga 200
    const double start = 0;
    double end = 500;
    double scale = foodList.last.calories/end;

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
    lastPaint
      ..strokeWidth = 10
      ..color = lastColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final r = Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h);

    //Linee della barra non completata e completata
    canvas.drawLine(Offset(start, start), Offset(start, end), uncompletedPaint); //Gli argomenti sono coordinate partenza, fine, e paint
    canvas.drawLine(Offset(start, end), Offset(start, end - value/scale), completedPaint);

    //Ciclo for per disegnare i pallini della barra
    canvas.drawCircle(Offset(start, end), 5, _selectPaint(value, 0));
    for (int i = 0; i < nfoods; i++) {
      canvas.drawCircle(Offset(start, end - foodList[i].calories/scale), 5, _selectPaint(value, i));
    }
    canvas.drawCircle(Offset(start, end - value/scale), 0.5, lastPaint);
  }

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