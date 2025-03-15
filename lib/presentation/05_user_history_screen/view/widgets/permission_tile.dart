import 'package:flutter/material.dart';
import '../../../../domain/entities/permission_entity.dart';
import 'date_box.dart';
import 'permission_details.dart';

class PermissionTile extends StatelessWidget {
  final PermissionEntity pemissionData;

  const PermissionTile({Key? key, required this.pemissionData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            DateBox(date: pemissionData.date),
            const SizedBox(width: 16),
            Expanded(child: PermissionDetails(pemissionData: pemissionData)),
          ],
        ),
      ),
    );
  }
}
