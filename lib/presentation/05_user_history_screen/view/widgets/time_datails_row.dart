import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/extensions.dart';
import 'time_column.dart';
import 'column_divider.dart';

class TimeDetailsRow extends StatelessWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;

  const TimeDetailsRow({
    Key? key,
    required this.checkIn,
    required this.checkOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int differenceHours =
        checkOut?.difference(checkIn ?? DateTime.now()).inHours ?? 0;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-in'),
            time: checkIn?.toFormattedTime() ?? "",
          ),
        ),
        const ColumnDivider(),
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-out'),
            time: checkOut?.toFormattedTime() ?? "",
          ),
        ),
        const ColumnDivider(),
        Expanded(
          flex: 2,
          child: TimeColumn(
            label: context.tr('total'),
            time: '$differenceHours ${context.tr('hours')}',
          ),
        ),
      ],
    );
  }
}
