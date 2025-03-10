import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resourses/styles_manager.dart';

class AdminGroupCardDetails extends StatelessWidget {
  final String groupName ;
  final int memberNum ;
  final String password ;
  const AdminGroupCardDetails({super.key, required this.groupName, required this.memberNum, required this.password});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(groupName , style: Styles.style18Medium(),),
        Text.rich(
        TextSpan( children: [
          TextSpan(text:context.tr("GroupMembersNum") , style: Styles.style16Medium()),
          TextSpan(text: "${memberNum}" , style: Styles.style16Medium()),
        ]
        )
        ),
           Text.rich(
        TextSpan( children: [
          TextSpan(text:context.tr("GroupPassword") , style: Styles.style16Medium()),
          TextSpan(text: "${password}" , style: Styles.style16Medium()),
        ]
        )
        )
      ],

    );
  }
}