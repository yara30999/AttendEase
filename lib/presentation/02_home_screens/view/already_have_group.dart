import 'package:flutter/material.dart';
import 'widgets/time/live_date_time.dart';
import 'widgets/user/group_check_details_row.dart';
import 'widgets/user/permission_btn.dart';
import 'widgets/user/check_in_out_button.dart';
import 'widgets/user/time_card.dart';

class AlreadyHaveGroup extends StatelessWidget {
  const AlreadyHaveGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TimeCard(),
          LiveDateTime(),
          CheckInOutButton(),
          PermissionBtn(),
          GroupCheckDetails(
            checkInTime: DateTime.now(),
            checkOutTime: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
