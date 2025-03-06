import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const MemberTile({
    Key? key,
    required this.name,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          name,
          style: Styles.style16Medium(),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: ColorsManager.red,
          ),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}