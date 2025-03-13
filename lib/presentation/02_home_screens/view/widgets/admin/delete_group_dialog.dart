import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resourses/colors_manager.dart';
import '../../../view_model/delete_group_cubit/delete_group_cubit.dart';

class DeleteGroupDialog extends StatelessWidget {
  final DeleteGroupCubit deleteGroupCubit;
  final String groupId;
  const DeleteGroupDialog({
    super.key,
    required this.deleteGroupCubit,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.tr('Confirm Delete')),
      content: Text(context.tr('DeleteMsg')),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.tr('Cancel')),
        ),
        TextButton(
          onPressed: () {
            deleteGroupCubit.deleteGroup(groupId);
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
