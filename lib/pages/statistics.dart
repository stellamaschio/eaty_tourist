import 'package:eaty_tourist/models/barObj.dart';
import 'package:eaty_tourist/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

bool changeWeek = false;

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
                  color: Color.fromARGB(169, 143, 240, 193),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${(provider.lastData.last.distance/100000).toStringAsPrecision(3)} km',
                  style: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
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
                  color: Color.fromARGB(169, 143, 240, 193),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${provider.lastData.last.steps} steps',
                  style: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
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
                  color: Color.fromARGB(169, 143, 240, 193),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${provider.lastData.last.calories.toInt()} cal',
                  style: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
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
                        provider.setStatDate(prevDay);
                        provider.makeItems();
                      }),
                  Consumer<HomeProvider>(
                      builder: (context, value, child) => Text(
                            DateFormat('dd MMMM yyyy').format(value.statDate),
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
                        DateTime newDay = selDay.add(const Duration(days: 1));
                          provider.dayLastTime(selDay.add(const Duration(days: 1)));
                          // data from time 00:01 of the next day
                          provider.getSelectedByTime(
                            DateUtils.dateOnly(selDay.add(provider.lastSelTime.difference(selDay)),),
                            provider.lastSelTime,
                            selDay.add(provider.lastSelTime.difference(selDay)),
                          );
                          provider.setStatDate(selDay.add(provider.lastSelTime.difference(selDay)));
                          provider.makeItems();
                        //weekCheck(selDay, selDay.add(provider.lastSelTime.difference(selDay))),
                      },
                    ),
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
              child: Consumer<HomeProvider>(
                builder: (context, value, child) => Graphic()),  
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
                        //provider.deleteSelectedDay(provider.statDate);
                      }),
                  // next week button
                  IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        provider.deleteSelected();
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

  void weekCheck(DateTime selDay, DateTime newday){
    if(selDay.weekday == 7 && newday.weekday == 1){
      changeWeek = true;
    }
    if(selDay.weekday == 1 && newday.weekday == 7){
      changeWeek = true;
    }
  }

}



// Interface color

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
  
  @override
  State<StatefulWidget> createState() => GraphicState();
}

class GraphicState extends State<Graphic> {
  

  // In dart, late keyword is used to declare a variable or field that will be initialized at a later time. 
  // It is used to declare a non-nullable variable that is not initialized at the time of declaration.

  int touchedGroupIndex = -1;

  //final Color barColor = Color.fromARGB(255, 228, 139, 238);

  late List<BarChartGroupData> items = [];
  double rap_max = 0;
  

  @override
  void initState() {
    super.initState();
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);

    DateTime date = provider.statDate;
    
    provider.dayLastTime(date);
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
                    color: Color.fromARGB(255, 228, 139, 238),
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
  /*
  List<BarChartGroupData> makeItems(HomeProvider prov){
    DateTime date = prov.showDate;
    BarObj today = prov.makeDay(date);
    int day = today.weekDay;
    int sun = 7;
    DateTime startDay = date.subtract(Duration(days: (day)));
    
    for(int i=1;i<day;i++){
      items.add(createItems(prov.makeDay(startDay.add(Duration(days: i)))));
      
      // code for the normalization of the values of the bars
      BarObj obj = prov.makeDay(startDay.add(Duration(days: i)));
      if(obj.calories > val_max){
        val_max = obj.calories;
      }
    }
    for(int j=0;j<=(sun-day);j++){
      items.add(createItems(prov.makeDay(date.add(Duration(days: j)))));

      // code for the normalization of the values of the bars
      BarObj obj = prov.makeDay(date.add(Duration(days: j)));
      if(obj.calories > val_max){
        val_max = obj.calories;
      }
    }
    return items;
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
  }*/

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
      child: Text(''),
    );
  }

  /*
  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: ,
          width: 7,
        ),
      ],
    );
  }*/
  
}

