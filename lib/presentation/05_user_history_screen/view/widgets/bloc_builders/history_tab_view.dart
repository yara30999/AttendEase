import 'package:flutter/material.dart';
import '../../../../../domain/entities/history_entity.dart';
import '../attendance_tile.dart';

class HistoryTabView extends StatelessWidget {
  final List<HistoryEntity> historyList;
  const HistoryTabView(this.historyList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: historyList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return AttendanceTile(
          checkIn: historyList[index].checkIn,
          checkOut: historyList[index].checkOut,
        );
      },
    );
  }
}
