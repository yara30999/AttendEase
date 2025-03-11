import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: ColorsManager.black,
    );
  }
}
