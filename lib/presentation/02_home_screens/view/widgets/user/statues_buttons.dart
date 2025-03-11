
import 'package:flutter/material.dart';

import 'check_in_out_btns.dart';
import 'permission_btn.dart';
import 'progress_circle.dart';

class StatusButtons extends StatelessWidget {
  final int workHours;
  const StatusButtons({super.key, required this.workHours});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ProgressCircle(workHours: workHours),
                CheckInOutBtns(),
              ],
            ),
          ),
          PermissionBtn(onPressed: () { }) //TODO: Handel permission logic
        ],
      ),
    );
  }
}
