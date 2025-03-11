import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/history_entity.dart';
import '../../view_model/user_history_bloc/user_history_bloc.dart';
import 'attendance_tile.dart';

class HistoryTabView extends StatelessWidget {
  const HistoryTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userHistory = getUserHistory(context);
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: _userHistory.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final _historyItem = _userHistory[index];
        return AttendanceTile(
          date: _historyItem.checkIn,
          checkIn: getTimeOfDayFromDateTime(_historyItem.checkIn),
          checkOut: getTimeOfDayFromDateTime(_historyItem.checkOut),
          totalHours: 8,
        );
      },
    );
  }
}

List<HistoryEntity> getUserHistory(BuildContext context) {
  final _userHistory = context.watch<UserHistoryBloc>().userHistory ?? <HistoryEntity>[];
  return _userHistory;
}

TimeOfDay? getTimeOfDayFromDateTime(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }

  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}