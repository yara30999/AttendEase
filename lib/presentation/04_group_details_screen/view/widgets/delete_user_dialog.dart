import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../view_model/delete_member_cubit/delete_member_from_group_cubit.dart';

class DeleteUserDialog extends StatelessWidget {
  final String userId;
  final DeleteMemberFromGroupCubit deleteMemberCubit;
  const DeleteUserDialog({
    super.key,
    required this.userId,
    required this.deleteMemberCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.tr('confirm_delete')),
      content: Text(context.tr('remove_this_member?')),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.tr('Cancel')),
        ),
        TextButton(
          onPressed: () {
            deleteMemberCubit.deleteMember(userId);
            Navigator.pop(context);
          },
          child: Text(
            context.tr('Delete'),
            style: const TextStyle(color: ColorsManager.red),
          ),
        ),
      ],
    );
  }
}
