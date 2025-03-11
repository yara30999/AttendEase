import 'package:flutter/material.dart';

import '../../../../resourses/colors_manager.dart';

class ProgressCircle extends StatelessWidget {
  final double progress = 0.7; // Progress value (0 to 1)
  final int workHours;
  const ProgressCircle({super.key, required this.workHours});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color primary = isDarkMode ? ColorsManager.grey : ColorsManager.paleCream;
    Color secondery = isDarkMode ? ColorsManager.deepRed : ColorsManager.emeraldGreen;
    return  SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress, // TODO: need culc Progress fun and replace the value
                  strokeWidth: 10,
                  backgroundColor: primary,
                  valueColor: AlwaysStoppedAnimation<Color>(secondery),
                ),
              );
  }
}