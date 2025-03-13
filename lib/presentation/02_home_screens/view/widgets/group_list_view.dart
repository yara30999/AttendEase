import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/extensions.dart';
import '../../../../domain/entities/auth_entity.dart';
import '../../../../domain/entities/group_entity.dart';
import '../../../01_auth_screens/view_model/auth_bloc/auth_bloc.dart';
import 'admin/admin_group_card.dart';
import 'user/user_group_card.dart';

class GroupListView extends StatelessWidget {
  final List<GroupEntity> groups;
  const GroupListView({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    final AuthenticationEntity currentUser = context.read<AuthBloc>().authObj!;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: groups.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (currentUser.role == Role.admin.name) {
          return AdminGroupCard(groupEntity: groups[index]);
        } else {
          return UserGroupCard(groupEntity: groups[index]);
        }
      },
      padding: EdgeInsets.only(bottom: 20),
    );
  }
}
