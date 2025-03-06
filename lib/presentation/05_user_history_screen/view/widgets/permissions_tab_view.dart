import 'package:flutter/material.dart';
import '../../../../app/extensions.dart';
import 'permission_tile.dart';

class PermissionsTabView extends StatelessWidget {
  const PermissionsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: PermissionType.values.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return PermissionTile(
          date: DateTime.now().subtract(Duration(days: index)),
          type: PermissionType.values[index],
          onTap: () {
            // TODO: Handle permission tile tap
          },
        );
      },
    );
  }
}