import 'package:flutter/material.dart';
import 'date_box.dart';
import 'time_datails_row.dart';

class AttendanceTile extends StatelessWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;

  const AttendanceTile({
    Key? key,
    required this.checkIn,
    required this.checkOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            DateBox(date: checkIn),
            const SizedBox(width: 12),
            Expanded(
              child: TimeDetailsRow(checkIn: checkIn, checkOut: checkOut),
            ),
          ],
        ),
      ),
    );
  }
}
