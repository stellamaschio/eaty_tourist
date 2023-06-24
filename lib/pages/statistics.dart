import 'package:eaty_tourist/models/barObj.dart';
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

DateTime today = DateTime.now();

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
                  (provider.selectedByTime.isEmpty)
                  ? '0 km'
                  : '${provider.selectedByTime.last.distance/100000} km',
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
                  (provider.selectedByTime.isEmpty)
                  ? '0 steps'
                  : '${provider.selectedByTime.last.steps} steps',
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
                  (provider.selectedByTime.isEmpty)
                  ? '0 cal'
                  : '${provider.selectedByTime.last.calories.toInt()} cal',
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
                        DateTime selDay = provider.showDate;
                        DateTime prevDay = selDay.subtract(const Duration(days: 1));
                        provider.getSelectedByTime(
                          DateUtils.dateOnly(prevDay),
                          DateTime(prevDay.year, prevDay.month, prevDay.day, 23,59),
                          prevDay,
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
                        DateTime selDay = provider.showDate;
                        provider.dayLastTime(selDay.add(const Duration(days: 1)));
                        Future.delayed(const Duration(milliseconds: 1), () => {
                          // data from time 00:01 of the next day
                          provider.getSelectedByTime(
                            DateUtils.dateOnly(selDay.add(provider.lastSelTime.difference(selDay)),),
                            provider.lastSelTime,
                            selDay.add(provider.lastSelTime.difference(selDay)),
                          ),
                        });
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
                  // previous week button
                  IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        
                      }),
                  // next week button
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

  double rap_max = 0;

  List<double> calList = [];
  List<BarChartGroupData>? items = [];


  @override
  void initState() {
    super.initState();
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);

    DateTime date = provider.showDate;
    provider.lastTime();
    provider.getSelectedByTime(
      DateUtils.dateOnly(date), 
      provider.dataLastTime, 
      date,
    );

    calList = getCalList(provider);

    // Qui ci sono i valori riportati nel grafico
    final barGroup1 = makeGroupData(0, provider.cal_week.first.calories);
    final barGroup2 = makeGroupData(1, provider.cal_week[2].calories);
    final barGroup3 = makeGroupData(2, provider.cal_week[3].calories);
    final barGroup4 = makeGroupData(3, provider.cal_week[4].calories);
    final barGroup5 = makeGroupData(4, provider.cal_week[5].calories);
    final barGroup6 = makeGroupData(5, provider.cal_week[6].calories);
    final barGroup7 = makeGroupData(6, provider.cal_week[2].calories);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    provider.makeWeekDay();
    makeItems(provider);

    showingBarGroups = items;
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

  void makeItems(HomeProvider prov){
    for(var element in prov.cal_week){
      items?.add(createItems(element));
    }
  }

  createItems(BarObj element){
      switch(element.weekDay){
        case 1:
          return makeGroupData(1, element.getCal());
        case 2:
          return makeGroupData(2, element.getCal());
        case 3:
          return makeGroupData(3, element.getCal());
        case 4:
          return makeGroupData(4, element.getCal());
        case 5:
          return makeGroupData(5, element.getCal());
        case 6:
          return makeGroupData(6, element.getCal());
        case 7:
          return makeGroupData(7, element.getCal());
        
      }
  }

  
  List<double> getCalList(HomeProvider prov){
    List<double> list = [];
    double val_max = 0;
    for(var element in prov.cal_week){
      list.add(element.getCal());
      if(element.getCal() >= val_max){
        val_max = element.getCal();
      }
    }
    rap_max = val_max*1.1;
    return list;
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

