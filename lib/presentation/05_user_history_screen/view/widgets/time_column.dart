import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class TimeColumn extends StatelessWidget {
  final String label;
  final String time;

  const TimeColumn({Key? key, required this.label, required this.time})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor =
        isDarkMode ?  ColorsManager.deepRed :  ColorsManager.darkTeal ;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: Styles.style12Medium().copyWith(color: primaryColor),
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: Styles.style12Medium().copyWith(
            color: ColorsManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
