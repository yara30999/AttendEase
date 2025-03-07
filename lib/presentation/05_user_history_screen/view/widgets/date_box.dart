import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class DateBox extends StatelessWidget {
  final DateTime date;

  const DateBox({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: ColorsManager.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            DateFormat('dd').format(date),
            style: Styles.style24Bold().copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            DateFormat('EEE').format(date).toUpperCase(),
            style: Styles.style14Medium().copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
