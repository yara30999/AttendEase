import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/functions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class GroupPasswordRow extends StatelessWidget {
  final String passwordTxt;
  const GroupPasswordRow({super.key, required this.passwordTxt});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text(context.tr('GroupPassword'), style: Styles.style16Medium()),
        Text(passwordTxt, style: Styles.style16Medium()),
        InkWell(
          child: const Icon(Icons.copy, size: 18),
          onTap: () {
            Clipboard.setData(ClipboardData(text: passwordTxt)).then((_) {
              showToast(context.tr('password_copied'), ColorsManager.black);
            });
          },
        ),
      ],
    );
  }
}
