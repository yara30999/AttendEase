import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/extensions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class PermissionDetails extends StatelessWidget {
  final PermissionType type;
  final DateTime date;

  const PermissionDetails({Key? key, required this.type, required this.date})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type.string, // Using the extension
              style: Styles.style16Medium().copyWith(
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? ColorsManager.deepRed
                        : ColorsManager.darkTeal,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('EEEE, MMMM d, y').format(date),
              style: Styles.style14Medium().copyWith(
                color: ColorsManager.black,
              ),
            ),
          ],
        ),
        type.icon, // Using the extension
      ],
    );
  }
}
