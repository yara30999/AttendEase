import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/di.dart';
import '../../../../domain/entities/auth_entity.dart';
import '../../../../domain/usecase/group_members_stream_usecase.dart';
import '../../../resourses/styles_manager.dart';

class TotalGroupMembersStreamBuilder extends StatelessWidget {
  final String groupId;
  const TotalGroupMembersStreamBuilder(this.groupId, {super.key});

  @override
  Widget build(BuildContext context) {
    final GroupMembersStreamUsecase _groupMembersStreamUsecase = instance();
    return StreamBuilder<List<AuthenticationEntity>>(
      stream: _groupMembersStreamUsecase.execute(groupId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('group members: ${snapshot.data}');
          int totalMembers = snapshot.data?.length ?? 0;
          return Text(
            context.tr("GroupMembersNum") + totalMembers.toString(),
            style: Styles.style16Medium(),
          );
        } else {
          debugPrint('there is no members in this group');
          return Text(
            context.tr("GroupMembersNum") + "0",
            style: Styles.style16Medium(),
          );
        }
      },
    );
  }
}
