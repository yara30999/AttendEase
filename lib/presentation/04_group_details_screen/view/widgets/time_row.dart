import 'package:flutter/material.dart';
import '../../../resourses/styles_manager.dart';

class TimeRow extends StatelessWidget {
  final String label;
  final String time;
  const TimeRow({super.key, required this.label, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Styles.style16Medium()),
        const SizedBox(width: 12),
        Text(time, style: Styles.style16Medium()),
      ],
    );
  }
}
