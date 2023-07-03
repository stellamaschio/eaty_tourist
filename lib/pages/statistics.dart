import 'package:eaty_tourist/providers/home_provider.dart';
import 'package:eaty_tourist/widgets/graphic.dart';
import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(169, 143, 240, 193),
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
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(169, 143, 240, 193),
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
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(169, 143, 240, 193),
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
              padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
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
                          provider.dayLastTime(selDay.add(const Duration(days: 1)));
                          // data from time 00:01 of the next day
                          DateTime newDay = selDay.add(provider.lastSelTime.difference(selDay));
                          provider.getSelectedByTime(
                            DateUtils.dateOnly(newDay),
                            provider.lastSelTime,
                            newDay,
                          );
                          provider.setStatDate(newDay);
                          provider.makeItems();
                      },
                    ),
                ],
              ),
            ),
            Divider(
              height: 40,
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

            /////////
            ///----------------
            /// Help for debugging
            /// --------------
            /// 
            /*
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // previous week button
                  IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                        color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      provider.deleteSelectedDay(provider.statDate);
                    }
                  ),
                  // next week button
                  IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                        color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      provider.deleteSelected();
                    }
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}




