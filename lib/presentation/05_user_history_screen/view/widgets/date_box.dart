import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class DateBox extends StatelessWidget {
  final DateTime date;

  const DateBox({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
    );
  }
}