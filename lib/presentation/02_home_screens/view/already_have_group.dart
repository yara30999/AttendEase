import 'package:flutter/material.dart';
import 'widgets/user/calender.dart';
import 'widgets/user/check_details_row.dart';
import 'widgets/user/statues_buttons.dart';
import 'widgets/user/time_card.dart';

class AlreadyHaveGroup extends StatelessWidget {
  const AlreadyHaveGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Calender(), // date
            TimeCard(), // time
            StatusButtons(
              workHours: 9 /* Replace the group work hours */,
            ), // state menu
            // time row
            CheckDetails(
              //
              chickinTime: TimeOfDay(
                hour: 9,
                minute: 0,
              ), // replace with actual time
              checkoutTime: TimeOfDay(
                hour: 15,
                minute: 0,
              ), // replace with actual time
              totalTime: 9,
            ), //replace with actual time
            // permission options
          ],
        ),
      ),
    );
  }
}
