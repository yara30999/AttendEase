import 'package:flutter/material.dart';
import '../../../../app/functions.dart';
import '../../../../domain/entities/auth_entity.dart';
import '../../../resourses/routes_manager.dart';
import 'member_tile.dart';

class MembersListView extends StatelessWidget {
  final List<AuthenticationEntity> members;
  const MembersListView(this.members, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return MemberTile(
          name: members[index].name,
          onTap: () {
            // Navigate to user history
            Navigator.pushNamed(
              context,
              Routes.userHistoryRoute,
              arguments: members[index],
            );
          },
          onDelete: () {
            //TODO: delete user from group yara.
            showDeleteUserConfirmationDialog(context);
          },
        );
      },
    );
  }
}
