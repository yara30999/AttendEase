import 'package:flutter/material.dart';
import '../../../../../domain/entities/permission_entity.dart';
import '../permission_tile.dart';

class PermissionsTabView extends StatelessWidget {
  final List<PermissionEntity> permissionsList;
  const PermissionsTabView(this.permissionsList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: permissionsList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return PermissionTile(
          date: permissionsList[index].date,
          type: permissionsList[index].type,
        );
      },
    );
  }
}
