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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: Styles.style12Medium().copyWith(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? ColorsManager.darkTeal 
                      : ColorsManager.deepRed,
            ),
            overflow: TextOverflow.visible, // change ellipsis to visible doesn't affect history screen but needed in attendes screen  remove comment after read 
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
