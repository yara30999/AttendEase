import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resourses/colors_manager.dart';

class CalenderList extends StatelessWidget {
  List<DateTime> generateWeekDates() {
    DateTime today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.month));
    return List.generate(14 , (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<DateTime> weekDates = generateWeekDates();
    bool isLight = (Theme.of(context).brightness ==  Brightness.light) ;
    return 
        Container(
          height: 70,
          child:
           ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: weekDates.length,
            separatorBuilder: (context, index) => SizedBox(width: 5,),
            itemBuilder: (context , index) {
              DateTime date = weekDates[index] ;
              bool isToday = date.day == today.day && date.month == today.month && date.year == today.year;
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: isToday ?  ( isLight ?  ColorsManager.emeraldGreen : ColorsManager.mutedRed  ) 
                               :  ( isLight ?ColorsManager.paleCream    :ColorsManager.grey  ) , // function not working 
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(DateFormat('EEE').format(date)), // local
                        Text(DateFormat('dd').format(date))   // local
                      ],
                    ),
                  ),
                ),
              );
            })
        );
  }
}
