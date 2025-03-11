import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'check_details_card.dart';

class CheckDetails extends StatelessWidget {
  final TimeOfDay chickinTime ;
  final TimeOfDay checkoutTime ;
  final int totalTime ;
  const CheckDetails({super.key, required this.chickinTime, required this.checkoutTime, required this.totalTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //TimeDetailsRow(checkIn: TimeOfDay(hour: 8, minute: 10), checkOut: TimeOfDay(hour: 5, minute: 22), totalHours: 6) ,
        CheckDetailsCard(label: context.tr('Check-in Time:'), time: chickinTime.format(context) ),
        CheckDetailsCard(label: context.tr('Check-out Time:'), time: checkoutTime.format(context) ),
        CheckDetailsCard(label: context.tr('total'), time: '$totalTime ${context.tr('hours') }' ),
      ],),
    );
  }
}