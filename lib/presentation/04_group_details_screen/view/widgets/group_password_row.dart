import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/functions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class GroupPasswordRow extends StatelessWidget {
  const GroupPasswordRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text(context.tr('passwordLabel'), style: Styles.style16Medium()),
        SizedBox(width: 8),
        Text(
          // Replace with actual password
          'XZ1235',
          style: Styles.style16Medium(),
        ),
        GestureDetector(
          child: const Icon(Icons.copy, size: 18),
          onTap: () {
            Clipboard.setData(const ClipboardData(text: 'XZ1235')).then((_) {
              showToast(context.tr('password_copied'), ColorsManager.black);
            });
          },
        ),
      ],
    );
  }
}
