import 'package:flutter/material.dart';

import '../../../../05_user_history_screen/view/widgets/time_column.dart';

class CheckDetailsCard extends StatelessWidget {
  final String label ;
  final String time ;
  const CheckDetailsCard({super.key, required this.label, required this.time});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: TimeColumn(label: label, time: time)),
        ),
      ),
    );
  }
}