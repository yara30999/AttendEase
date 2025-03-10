import 'package:flutter/material.dart';

import '../../../../app/functions.dart';
import 'admin/admin_group_card.dart';
import 'user/user_group_card.dart';

class GroupListView extends StatelessWidget {
  final bool isAdmin ;
  const GroupListView({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Replace with actual members count
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        //TODO:check if admin or user to show the right group card
      if( isAdmin  )  {
        return AdminGroupCard(
          groupName: 'Group $index',  // replace with actual group name
          memberNum: 9 ,              // replace with actual members num
          groupPassword : generateRandomPassword(),
          );
       }else { return
         UserGroupCard(
          groupName: 'Group $index', // replace with actual group name
          memberNum: 9,              // replace with actual members num
          );
      }
      },
    );
    
  }
}
