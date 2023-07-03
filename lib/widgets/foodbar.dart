import 'package:eaty_tourist/models/foods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Foodbar extends CustomPainter {

  //Constructor of the class
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

  final Color backColor, frontColor, lastColor;
  final double strokeWidth, value, scale, upBar, downBar;
  final List<Foods> foodList;

  //number of foods
  late int nfoods = foodList.length;

  //types of paint
  final uncompletedPaint = Paint();
  final completedPaint = Paint();
  final indicatorPaint = Paint();


  @override
  void paint(Canvas canvas, Size size) {

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
      ..strokeWidth = 8
      ..color = lastColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //Lines of the bar completed and uncompleted
    //Arguments are start, end, and paint
    canvas.drawLine(Offset(0, upBar), Offset(0, downBar), uncompletedPaint); 
    if((value/scale)>700/scale){
      canvas.drawLine(Offset(0, downBar), Offset(0, downBar - 700/scale), completedPaint);
    }
    else{
      canvas.drawLine(Offset(0, downBar), Offset(0, downBar - value/scale), completedPaint);
    }

    //Point at the start of the bar
    canvas.drawCircle(Offset(0, downBar), 4, _paintFirstDot(value));

    //Cicle to draw the points of the bar
    for (int i = 0; i < nfoods; i++) {
      canvas.drawCircle(Offset(0, downBar - foodList[i].calories/scale), 4, _selectPaint(value, i));

      //text of every points
      final icon = foodList[i].icon;
      const double fontsize = 37;
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
          package: icon.fontPackage, 
        ),
      );
      iconPainter.layout();
      iconPainter.paint(canvas, Offset(0 - 65, downBar - foodList[i].calories/scale - fontsize/2));

      //display text icon (calories)
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr,
        text: TextSpan(
            text: '$textCal cal',
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0 - 75, (downBar - foodList[i].calories/scale - fontsize/2)+35));
    
      // display food name
      TextPainter foodPainter = TextPainter(textDirection: TextDirection.ltr,
        text: TextSpan(
            text: food,
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
      );
      foodPainter.layout();
      foodPainter.paint(canvas, Offset(0 + 25, (downBar - foodList[i].calories/scale - fontsize/2)+10));
    
    }

    //indicator of the actual progress of the bar
    canvas.drawCircle(Offset(0, downBar - value/scale), 0.5, indicatorPaint);

  }

  // methods for selecting the paint for the points of the bar
  Paint _selectPaint(double value, int foodIndex) {
    if(value >= foodList[foodIndex].calories) {
      return completedPaint;
    }
    else {
      return uncompletedPaint;
    }
  }
   
  // paint the first point of the bar
  Paint _paintFirstDot(double value){
    if(value>0){
      return completedPaint;
    }
    else {
      return uncompletedPaint;
    }
  }

  // method for selecting the color for the points (foods) of the bar
  Color _selectColor(double value, int foodIndex) {
    if(value >= foodList[foodIndex].calories) {
      return const Color(0xFF607D8B);
    }
    else {
      return const Color(0xA969F0AF);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}