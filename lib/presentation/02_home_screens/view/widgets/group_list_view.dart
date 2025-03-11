import 'package:flutter/material.dart';
import '../../../../domain/entities/group_entity.dart';
import 'admin/admin_group_card.dart';
import 'user/user_group_card.dart';

class GroupListView extends StatelessWidget {
  final bool isAdmin;
  final List<GroupEntity> groups;
  const GroupListView({super.key, required this.isAdmin, required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groups.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (isAdmin) {
          return AdminGroupCard(groupEntity: groups[index]);
        } else {
          return UserGroupCard(groupEntity: groups[index]);
        }
      },
      padding: EdgeInsets.only(bottom: 20),
    );
  }
}
