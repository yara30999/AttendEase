import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,
      child: Card(
        elevation: 4,
        color: isDarkMode ?  ColorsManager.grey: ColorsManager.paleCream,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.watch_later,
                size: 50, 
                //color: isLightTheme(context) ? ColorsManager.emeraldGreen : ColorsManager.mutedRed,), //function not working
                color: isDarkMode ?  ColorsManager.mutedRed : ColorsManager.emeraldGreen ,),
                SizedBox(width: 10,),
                Text( DateFormat('hh : mm a').format(DateTime.now()) , style: Styles.style24Bold(),),
              ],
            ),
          ),
      ),
    );
  }
}