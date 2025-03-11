import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resourses/styles_manager.dart';
import 'calender_list.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat('MMMM yyyy').format(DateTime.now()), // local and align 
          style: Styles.style20Bold(),
        ),
        SizedBox(height: 5),
        CalenderList(), 
      ],
    );
  }
}
