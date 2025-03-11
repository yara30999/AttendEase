import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../resourses/assets_manager.dart';
import '../../../../resourses/styles_manager.dart';

class EmptyStateWidget extends StatelessWidget {
  final String label;
  final double width;
  const EmptyStateWidget(
      {super.key, this.width = double.infinity, required this.label});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 30.0,
        children: [
          SizedBox(height: 30.0),
          Text(
            label,
            style: Styles.style20Bold(),
          ),
          Lottie.asset(
            JsonAssets.empty,
            width: width,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
