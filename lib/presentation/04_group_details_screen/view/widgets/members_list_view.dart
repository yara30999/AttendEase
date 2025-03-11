import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/functions.dart';
import '../../../../domain/entities/auth_entity.dart';
import '../../../resourses/routes_manager.dart';
import '../../view_model/group_members_bloc/group_members_bloc.dart';
import 'member_tile.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getGroupMembers(context).length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final _groupMember = getGroupMembers(context)[index];
        final _memberName = _groupMember.name;
        return MemberTile(
          name: _memberName,
          onTap: () {
            // Navigate to user history
            Navigator.pushNamed(context, Routes.userHistoryRoute);
          },
          onDelete: () {
            showDeleteUserConfirmationDialog(context);
          },
        );
      },
    );
  }
}

List<AuthenticationEntity> getGroupMembers(BuildContext context) {
    final _groupMembers = context.watch<GroupMembersBloc>().groupMembers ?? <AuthenticationEntity>[];
    return _groupMembers;
}
