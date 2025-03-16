import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/functions.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../resourses/styles_manager.dart';
import '../../../view_model/join_group_cubit/join_group_cubit.dart';
import '../group_avatar.dart';
import '../total_group_members_stream_builder.dart';

class UserGroupCard extends StatelessWidget {
  final GroupEntity groupEntity;
  const UserGroupCard({super.key, required this.groupEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final joinGroupCubit = context.read<JoinGroupCubit>();
        showJoinGroupBottomSheet(context, groupEntity, joinGroupCubit);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              GroupAvatar(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(groupEntity.name, style: Styles.style18Medium()),
                    TotalGroupMembersStreamBuilder(groupEntity.id),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
