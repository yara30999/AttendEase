import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';
import 'date_box.dart';

class AttendanceTile extends StatelessWidget {
  final DateTime date;
  final TimeOfDay checkIn;
  final TimeOfDay checkOut;
  final int totalHours;

  const AttendanceTile({
    Key? key,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.totalHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 4,
      color: isDarkMode ? ColorsManager.mediumBrown : ColorsManager.creamyBeige,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Reduced padding
        child: Row(
          children: [
            DateBox(date: date),
            const SizedBox(width: 12), // Reduced spacing
            Expanded(
              child: TimeDetailsRow(
                checkIn: checkIn,
                checkOut: checkOut,
                totalHours: totalHours,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeDetailsRow extends StatelessWidget {
  final TimeOfDay checkIn;
  final TimeOfDay checkOut;
  final int totalHours;

  const TimeDetailsRow({
    Key? key,
    required this.checkIn,
    required this.checkOut,
    required this.totalHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-in'),
            time: checkIn.format(context),
            icon: Icons.login_outlined,
          ),
        ),
        const CustomVerticalDivider(),
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-out'),
            time: checkOut.format(context),
            icon: Icons.logout_outlined,
          ),
        ),
        const CustomVerticalDivider(),
        Expanded(
          flex: 2,
          child: TimeColumn(
            label: context.tr('Total'),
            time: '$totalHours ${context.tr('hrs')}',
            icon: Icons.access_time,
          ),
        ),
      ],
    );
  }
}

class TimeColumn extends StatelessWidget {
  final String label;
  final String time;
  final IconData icon;

  const TimeColumn({
    Key? key,
    required this.label,
    required this.time,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = isDarkMode
        ? ColorsManager.sandYellow
        : ColorsManager.darkBrown;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: primaryColor,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: Styles.style12Medium().copyWith(
                  color: primaryColor.withOpacity(0.7),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: Styles.style12Medium().copyWith(
            color: isDarkMode ? ColorsManager.white : ColorsManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 50,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: (isDarkMode ? ColorsManager.sandYellow : ColorsManager.darkBrown)
          .withOpacity(0.3),
    );
  }
}