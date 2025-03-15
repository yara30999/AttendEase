import 'package:flutter/material.dart';
import '../../../../domain/entities/history_entity.dart';
import 'date_box.dart';
import 'time_datails_row.dart';

class AttendanceTile extends StatelessWidget {
  final HistoryEntity historyData;

  const AttendanceTile({Key? key, required this.historyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            DateBox(date: historyData.checkIn),
            const SizedBox(width: 12),
            Expanded(child: TimeDetailsRow(historyData: historyData)),
          ],
        ),
      ),
    );
  }
}
