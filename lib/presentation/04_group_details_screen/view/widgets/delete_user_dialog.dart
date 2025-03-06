import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resourses/colors_manager.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.tr('Confirm Delete')),
      content: Text(context.tr('Are you sure you want to remove this member?')),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.tr('Cancel')),
        ),
        TextButton(
          onPressed: () {
            // TODO: Implement delete logic
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
