import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart';

class foodbar extends CustomPainter {

  //Costruttore della classe
  const foodbar(
      {required this.backColor,
      required this.frontColor,
      required this.strokeWidth,
      required this.value,
      required this.nfoods});

  //Variabili della classe
  final Color backColor, frontColor;
  final double strokeWidth, value;
  final int nfoods;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    //Valori dipartenza e fine delle linee
    //NOTA: Widget all'interno di una sized box centrata e larga 200
    const double start = 0;
    const double end = 200;

    final uncompletedPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = backColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final completedPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = frontColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final r = Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h);

    //Linee della barra non completata e completata
    canvas.drawLine(Offset(start, h / 2), Offset(end, h / 2), uncompletedPaint); //Gli argomenti sono coordinate partenza, fine, e paint
    canvas.drawLine(Offset(start, h / 2), Offset(start + value, h / 2), completedPaint);

    //Ciclo for per disegnare i pallini della barra
    for (int i = 0; i < nfoods; i++) {
      canvas.drawCircle(Offset(start + (i*(end-start))/(nfoods-1), h / 2), 2, uncompletedPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}