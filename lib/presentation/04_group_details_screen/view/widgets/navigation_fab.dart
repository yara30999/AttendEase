import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class NavigationFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const NavigationFAB({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor:
          isDarkMode ? ColorsManager.sandYellow : ColorsManager.darkBrown,
      label: Row(
        children: [
          Icon(
            Icons.navigation_rounded,
            color: isDarkMode ? ColorsManager.darkBrown : ColorsManager.white,
          ),
          const SizedBox(width: 8),
          Text(
            context.tr('Navigate'),
            style: Styles.style14Medium().copyWith(
              color: isDarkMode ? ColorsManager.darkBrown : ColorsManager.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
