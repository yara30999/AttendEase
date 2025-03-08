import 'package:flutter/material.dart';
import '../../../../app/extensions.dart';
import 'date_box.dart';
import 'permission_details.dart';

class PermissionTile extends StatelessWidget {
  final DateTime date;
  final PermissionType type;
  final VoidCallback onTap;

  const PermissionTile({
    Key? key,
    required this.date,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              DateBox(date: date),
              const SizedBox(width: 16),
              Expanded(child: PermissionDetails(type: type, date: date)),
            ],
          ),
        ),
      ),
    );
  }
}
