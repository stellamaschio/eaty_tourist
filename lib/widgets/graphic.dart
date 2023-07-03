import 'package:eaty_tourist/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Graphic class
class Graphic extends StatefulWidget {
  Graphic({super.key});
  
  @override
  State<StatefulWidget> createState() => GraphicState();
}

class GraphicState extends State<Graphic> {
  
  double graphic_height= 250;

  // Font
  var font = GoogleFonts.montserrat(
    color: const Color.fromARGB(255, 107, 107, 107),
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  double rap_max = 0;
  

  @override
  void initState() {
    super.initState();
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);

    DateTime date = provider.statDate;
    provider.dayLastTimeBars(date);
    provider.getSelectedByTime(
      DateUtils.dateOnly(date), 
      provider.lastSelTime, 
      date,
    );

    provider.makeItems();
    
    rap_max = provider.val_max;
      
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) => Padding(
        // Qui viene impostato il valore di padding del grafico dal bordo schermo.
        padding: const EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 228, 139, 238),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Text("cal/day",
                    style: font,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: graphic_height,
              child: BarChart(
                BarChartData(
                  maxY: rap_max,
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: rightTitles,
                        reservedSize: 15,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 32,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                    ),
                  barGroups: provider.items,
                  gridData: FlGridData(
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    var style = font.copyWith(fontSize: 12);
    String text;
    if (value == (rap_max*(1/5)).toInt()) {
      text = (rap_max*(1/5)).toInt().toString();
    } 
    else if (value == (rap_max*(2/5)).toInt()) {
      text = (rap_max*(2/5)).toInt().toString();
    } 
    else if (value == (rap_max*(3/5)).toInt()) {
      text = (rap_max*(3/5)).toInt().toString();
    } 
    else if (value == (rap_max*(4/5)).toInt()) {
      text = (rap_max*(4/5)).toInt().toString();
    } 
    else if (value == (rap_max*(5/5)).toInt()) {
      text = (rap_max*(5/5)).toInt().toString();
    } 
    else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()-1],
      style: font.copyWith(fontSize: 14,),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10, //margin top
      child: text,
    );
  }

  Widget rightTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10, //margin top
      child: const Text(''),
    );
  }
  
}
