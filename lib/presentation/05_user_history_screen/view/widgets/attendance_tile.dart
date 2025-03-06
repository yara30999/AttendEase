import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Date Container with day number and name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? ColorsManager.darkBrown.withOpacity(0.3)
                    : ColorsManager.sandYellow.withOpacity(0.3),
                border: Border.all(
                  color: isDarkMode
                      ? ColorsManager.sandYellow
                      : ColorsManager.darkBrown,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('dd').format(date),
                    style: Styles.style24Bold().copyWith(
                      color: isDarkMode
                          ? ColorsManager.sandYellow
                          : ColorsManager.darkBrown,
                    ),
                  ),
                  Text(
                    DateFormat('EEE').format(date).toUpperCase(),
                    style: Styles.style14Medium().copyWith(
                      color: isDarkMode
                          ? ColorsManager.sandYellow
                          : ColorsManager.darkBrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Time details
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Check-in time
                  Expanded(
                    child: _buildTimeColumn(
                      context,
                      'Check-in Time:'.tr(),
                      checkIn.format(context),
                      Icons.login,
                      isDarkMode,
                    ),
                  ),
                  // Vertical divider
                  Container(
                    height: 40,
                    width: 1,
                    color: isDarkMode
                        ? ColorsManager.sandYellow.withOpacity(0.3)
                        : ColorsManager.darkBrown.withOpacity(0.3),
                  ),
                  // Check-out time
                  Expanded(
                    child: _buildTimeColumn(
                      context,
                      'Check-out Time:'.tr(),
                      checkOut.format(context),
                      Icons.logout,
                      isDarkMode,
                    ),
                  ),
                  // Vertical divider
                  Container(
                    height: 40,
                    width: 1,
                    color: isDarkMode
                        ? ColorsManager.sandYellow.withOpacity(0.3)
                        : ColorsManager.darkBrown.withOpacity(0.3),
                  ),
                  // Total hours
                  Expanded(
                    child: _buildTimeColumn(
                      context,
                      'total'.tr(),
                      '$totalHours ${'hours'.tr()}',
                      Icons.timer,
                      isDarkMode,
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

  Widget _buildTimeColumn(
      BuildContext context,
      String label,
      String time,
      IconData icon,
      bool isDarkMode,
      ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isDarkMode
                  ? ColorsManager.sandYellow
                  : ColorsManager.darkBrown,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: Styles.style12Medium().copyWith(
                  color: isDarkMode
                      ? ColorsManager.sandYellow.withOpacity(0.7)
                      : ColorsManager.darkBrown.withOpacity(0.7),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: Styles.style14Medium().copyWith(
            color: isDarkMode
                ? ColorsManager.white
                : ColorsManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}