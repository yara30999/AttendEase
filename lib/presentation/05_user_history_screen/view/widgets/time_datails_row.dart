import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'time_column.dart';

class TimeDetailsRow extends StatelessWidget {
  final TimeOfDay checkIn;
  final TimeOfDay checkOut;
  final int totalHours;

  const TimeDetailsRow({
    Key? key,
    required this.checkIn,
    required this.checkOut,
    required this.totalHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-in'),
            time: checkIn.format(context),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-out'),
            time: checkOut.format(context),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 2,
          child: TimeColumn(
            label: context.tr('total'),
            time: '$totalHours ${context.tr('hours')}',
          ),
        ),
      ],
    );
  }
}
