import 'package:flutter/material.dart';
import '../../../../../app/extensions.dart';
import 'check_in_out_container.dart';
import 'progress_circle.dart';

class CheckInOutButton extends StatelessWidget {
  const CheckInOutButton({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Check in logic
        // and
        //TODO: Check out logic
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CheckInOutContainer(checkStatus: CheckStatus.checkIn),
            ProgressCircle(
              groupCheckOutTime: DateTime.now(),
              userCheckInTime: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
