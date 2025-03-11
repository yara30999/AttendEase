import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../resourses/assets_manager.dart';
import '../../../../resourses/styles_manager.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorText;
  final double width;
  const ErrorStateWidget({
    super.key,
    this.width = double.infinity,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(JsonAssets.error, fit: BoxFit.contain, width: width),
          Text(
            errorText,
            style: Styles.style20Bold(),
          ),
        ],
      ),
    );
  }
}
