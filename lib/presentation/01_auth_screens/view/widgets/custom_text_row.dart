import 'package:flutter/material.dart';
import '../../../resourses/styles_manager.dart';

class CustomTextRow extends StatelessWidget {
  final String questionTxt, clickTxt;
  final void Function()? onTap;

  const CustomTextRow({
    super.key,
    required this.questionTxt,
    required this.clickTxt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          questionTxt,
          style: Styles.style16Medium(),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            clickTxt,
          ),
        )
      ],
    );
  }
}
