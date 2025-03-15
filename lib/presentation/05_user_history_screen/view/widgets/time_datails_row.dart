import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/extensions.dart';
import '../../../../domain/entities/history_entity.dart';
import 'time_column.dart';
import 'column_divider.dart';

class TimeDetailsRow extends StatelessWidget {
  final HistoryEntity historyData;

  const TimeDetailsRow({Key? key, required this.historyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int differenceHours =
        historyData.checkOut
            ?.difference(historyData.checkIn ?? DateTime.now())
            .inHours ??
        0;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-in'),
            time: historyData.checkIn?.toFormattedTime() ?? "",
          ),
        ),
        const ColumnDivider(),
        Expanded(
          flex: 3,
          child: TimeColumn(
            label: context.tr('Check-out'),
            time: historyData.checkOut?.toFormattedTime() ?? "",
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
