import 'package:flutter/material.dart';
import 'attendance_tile.dart';

class HistoryTabView extends StatelessWidget {
  const HistoryTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: 10,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return AttendanceTile(
          date: DateTime.now().subtract(Duration(days: index)),
          checkIn: const TimeOfDay(hour: 9, minute: 0),
          checkOut: const TimeOfDay(hour: 17, minute: 0),
          totalHours: 8,
        );
      },
    );
  }
}