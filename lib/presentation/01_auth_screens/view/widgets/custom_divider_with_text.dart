import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class CustomDividerWithText extends StatelessWidget {
  final String label;

  const CustomDividerWithText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        const Expanded(flex: 6, child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: Styles.style16Medium().copyWith(
              color: ColorsManager.mutedRed,
            ),
          ),
        ),
        const Expanded(flex: 6, child: Divider()),
        const Spacer(),
      ],
    );
  }
}
