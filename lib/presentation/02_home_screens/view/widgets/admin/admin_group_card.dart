import 'package:flutter/material.dart';

import '../../../../../app/functions.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/routes_manager.dart';
import 'admin_group_card_details.dart';


class AdminGroupCard extends StatelessWidget {
  final groupName ;
  final memberNum ;
  final groupPassword ;
  const AdminGroupCard({super.key, required this.groupName, required this.memberNum, required this.groupPassword});

  @override
  Widget build(BuildContext context) {  
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap:() {Navigator.pushNamed(context, Routes.groupDetailsRoute); } ,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
               //TODO: avatar
              const SizedBox(width: 16),
              Expanded(child: AdminGroupCardDetails(groupName: groupName, memberNum: memberNum, password: groupPassword,)),
              IconButton(
          icon: const Icon(Icons.delete, color: ColorsManager.deepRed),
          onPressed: () {showDeleteGroupConfirmationDialog(context);}, 
        ),
            ],
          ),
        ),
      ),

    );
  }
}