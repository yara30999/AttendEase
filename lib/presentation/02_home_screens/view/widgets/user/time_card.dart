import 'package:flutter/material.dart';
import '../../../../resourses/colors_manager.dart';
import '../time/live_hour_time.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,
      child: Card(
        elevation: 4,
        color:
            Theme.of(context).brightness == Brightness.light
                ? ColorsManager.paleCream
                : ColorsManager.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.watch_later,
                size: 50,
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? ColorsManager.emeraldGreen
                        : ColorsManager.mutedRed,
              ),
              SizedBox(width: 10),
              LiveHourTime(),
            ],
          ),
        ),
      ),
    );
  }
}
