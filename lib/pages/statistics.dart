import 'package:eaty_tourist/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) => Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xA969F0AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${provider.data.distance/100000} km',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF607D8B),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xA969F0AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${provider.data.steps} steps',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF607D8B),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xA969F0AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${provider.data.calories.toInt()} cal',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF607D8B),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        DateTime day = provider.showDate;
                        DateTime newDay = day.subtract(const Duration(days: 1));
                        provider.getSelectedByTime(
                          DateUtils.dateOnly(newDay),
                          DateTime(newDay.year, newDay.month, newDay.day, 23,59),
                          newDay,
                        );
                      }),
                  Consumer<HomeProvider>(
                      builder: (context, value, child) => Text(
                            DateFormat('dd MMMM yyyy').format(value.showDate),
                            style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                  IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        DateTime day = provider.showDate;
                        DateTime newDay = day.add(const Duration(days: 1));
                        provider.getSelectedByTime(
                          DateUtils.dateOnly(newDay),
                          DateTime(newDay.year, newDay.month, newDay.day, 23,59),
                          newDay,
                        );
                      })
                ],
              ),
            ),
            Divider(
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Container(
                child: Graphic(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "previous week",
                    style: GoogleFonts.montserrat(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        
                      }),
                  Text(
                    "next week",
                    style: GoogleFonts.montserrat(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Interface color
Color bar_1= Color.fromARGB(255, 228, 139, 238);

// Definizione altezza grafico
// ignore: non_constant_identifier_names
double altezza_grafico= 250;

// Font
var font = GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 107, 107, 107),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    );

//Valori calorici nel grafico
Map<String,double> calorie_giorno= {"Mn":2100, "Te":2000, "Wd":1643, "Tu":890, "Fr":2600, "St":1999, "Su":3000};

//Valore massimo e rappresentazione massima del grafico
    List<double> calorie = calorie_giorno.values.toList();
    double val_max= calorie.reduce((a, b) => a > b ? a : b);
    double rap_max= val_max*1.1;

// Graphic class
class Graphic extends StatefulWidget {
  Graphic({super.key});
  final Color leftBarColor = bar_1;
  @override
  State<StatefulWidget> createState() => GraphicState();
}

class GraphicState extends State<Graphic> {
  final double width = 7;

  // In dart, late keyword is used to declare a variable or field that will be initialized at a later time. 
  // It is used to declare a non-nullable variable that is not initialized at the time of declaration.
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);
    DateTime date = provider.showDate;
    provider.getSelectedByTime(
      DateUtils.dateOnly(date), 
      DateTime(date.year, date.month, date.day, 23, 59), date,
    );

    // Qui ci sono i valori riportati nel grafico
    final barGroup1 = makeGroupData(0, calorie_giorno["Mn"]!);
    final barGroup2 = makeGroupData(1, calorie_giorno["Te"]!);
    final barGroup3 = makeGroupData(2, calorie_giorno["Wd"]!);
    final barGroup4 = makeGroupData(3, calorie_giorno["Tu"]!);
    final barGroup5 = makeGroupData(4, calorie_giorno["Fr"]!);
    final barGroup6 = makeGroupData(5, calorie_giorno["St"]!);
    final barGroup7 = makeGroupData(6, calorie_giorno["Su"]!);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        // Qui viene impostato il valore di padding del grafico dal bordo schermo.
        padding: const EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: bar_1
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
              height: altezza_grafico,
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
                  barGroups: showingBarGroups,
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
    if (value == rap_max*(1/5)) {
      text = (rap_max*(1/5)).toInt().toString();
    } 
    else if (value == rap_max*(2/5)) {
      text = (rap_max*(2/5)).toInt().toString();
    } 
    else if (value == rap_max*(3/5)) {
      text = (rap_max*(3/5)).toInt().toString();
    } 
    else if (value == rap_max*(4/5)) {
      text = (rap_max*(4/5)).toInt().toString();
    } 
    else if (value == rap_max*(5/5)) {
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
      titles[value.toInt()],
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
      child: Text(''),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
      ],
    );
  }
}

