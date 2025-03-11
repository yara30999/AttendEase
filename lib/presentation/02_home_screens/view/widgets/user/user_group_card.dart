import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resourses/styles_manager.dart';
import '../group_avatar.dart';
import 'custom_bottom_sheet.dart';

class UserGroupCard extends StatelessWidget {
  final groupName;
  final memberNum;
  const UserGroupCard({
    super.key,
    required this.groupName,
    required this.memberNum,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          showBottomSheet(context: context, builder: (context) => CustomBottomSheet());
        },
        borderRadius: BorderRadius.circular(12),
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
                    Text(groupName, style: Styles.style18Medium()),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: context.tr("GroupMembersNum"),
                            style: Styles.style16Medium(),
                          ),
                          TextSpan(
                            text: "${memberNum}",
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
