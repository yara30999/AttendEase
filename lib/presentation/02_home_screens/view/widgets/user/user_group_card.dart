import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../app/functions.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../resourses/styles_manager.dart';
import '../group_avatar.dart';

class UserGroupCard extends StatelessWidget {
  final GroupEntity groupEntity;
  const UserGroupCard({super.key, required this.groupEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showJoinGroupBottomSheet(context, groupEntity);
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
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: context.tr("GroupMembersNum"),
                            style: Styles.style16Medium(),
                          ),
                          TextSpan(
                            //TODO i will give you a usecase for this... soon. by yara
                            text: "6",
                            style: Styles.style16Medium(),
                          ),
                        ],
                      ),
                    ),
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
