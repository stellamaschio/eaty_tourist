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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xA969F0AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${provider.selectedDistance/100} km',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF607D8B),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xA969F0AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${provider.selectedDistance} steps',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF607D8B),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        DateTime day =
                            Provider.of<HomeProvider>(context, listen: false)
                                .showDate;
                        Provider.of<HomeProvider>(context, listen: false)
                            .getDataOfDay(
                                day.subtract(const Duration(days: 1)));
                      }),
                  Consumer<HomeProvider>(
                      builder: (context, value, child) => Text(
                            DateFormat('dd MMMM yyyy').format(value.showDate),
                            style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                  IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        DateTime day =
                            Provider.of<HomeProvider>(context, listen: false)
                                .showDate;
                        Provider.of<HomeProvider>(context, listen: false)
                            .getDataOfDay(day.add(const Duration(days: 1)));
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
              child: Container(
                child: Grafico2(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Definizione dei colori dell'interfaccia
Color barra_1= const Color.fromARGB(255, 48, 232, 232);
Color barra_2= const Color.fromARGB(255, 255, 182, 24);
Color barra_3= const Color.fromARGB(255, 217, 84, 232);

// Definizione altezza grafico
// ignore: non_constant_identifier_names
double altezza_grafico= 250;

// Definizione dello stile di carattere usato
var font = GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 107, 107, 107),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    );

/*
//Definizione del grafico 1
class Grafico1 extends StatefulWidget {
  Grafico1({super.key});
  final Color leftBarColor = barra_2;
  final Color rightBarColor = barra_1;
  @override
  State<StatefulWidget> createState() => Grafico1State();
}

class Grafico1State extends State<Grafico1> {
  final double width = 7;

  // In dart, late keyword is used to declare a variable or field that will be initialized at a later time. 
  // It is used to declare a non-nullable variable that is not initialized at the time of declaration.
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    // Qui ci sono i valori riportati nel grafico
    final barGroup1 = makeGroupData(0, 10, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

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
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        // Qui viene impostato il valore di padding del grafico dal bordo schermo.
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 48, 232, 232)),
                  padding: const EdgeInsets.all(5),
                  child: Text("km/day",
                  style: font),),
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 255, 182, 24)),
                  padding: const EdgeInsets.all(5),
                  child: Text("time/day",
                  style: font,)),
              ],
            ),
            const SizedBox(
              height: 38,
            ),
            Container(
              height: altezza_grafico,
              child: BarChart(
                BarChartData(
                  maxY: 18,
                  /*
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => (null),
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: widget.avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  */
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 18,
                        interval: 1,
                        getTitlesWidget: rightTitles,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 18,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget rightTitles(double value, TitleMeta meta) {
    var style = font.copyWith(fontSize: 14, decorationColor: barra_2, 
      decoration: TextDecoration.underline, decorationThickness: 5);
    String text;
    if (value == 6) {
      text = '6';
    } else if (value == 12) {
      text = '12';
    } else if (value == 18) {
      text = '18';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    var style = font.copyWith(fontSize: 14, decorationColor: barra_1, 
      decoration: TextDecoration.underline, decorationThickness: 5);
    String text;
    if (value == 6) {
      text = '10';
    } else if (value == 12) {
      text = '20';
    } else if (value == 18) {
      text = '30';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
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
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
*/

// Definzione del grafico 2
class Grafico2 extends StatefulWidget {
  Grafico2({super.key});
  final Color leftBarColor = barra_3;
  @override
  State<StatefulWidget> createState() => Grafico2State();
}

class Grafico2State extends State<Grafico2> {
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
    // Qui ci sono i valori riportati nel grafico
    final barGroup1 = makeGroupData(0, provider.totalCalories);
    final barGroup2 = makeGroupData(1, 16);
    final barGroup3 = makeGroupData(2, 18);
    final barGroup4 = makeGroupData(3, 20);
    final barGroup5 = makeGroupData(4, 17);
    final barGroup6 = makeGroupData(5, 19);
    final barGroup7 = makeGroupData(6, 10);

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
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        // Qui viene impostato il valore di padding del grafico dal bordo schermo.
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: barra_3),
                  padding: const EdgeInsets.all(5),
                  child: Text("km/day",
                  style: font),),
              ],
            ),
            const SizedBox(
              height: 38,
            ),
            Container(
              height: altezza_grafico,
              child: BarChart(
                BarChartData(
                  maxY: 4500,
                  /*
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => (null),
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: widget.avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  */
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    var style = font.copyWith(fontSize: 14, decorationColor: barra_3, 
      decoration: TextDecoration.underline, decorationThickness: 5);
    String text;
    if (value == 6) {
      text = '10';
    } else if (value == 12) {
      text = '20';
    } else if (value == 18) {
      text = '30';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
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
      space: 16, //margin top
      child: text,
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

