import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resourses/assets_manager.dart';
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
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: SvgPicture.asset(
            SvgAssets.name,
            fit: BoxFit.scaleDown,
            colorFilter: const ColorFilter.mode(
              ColorsManager.grey,
              BlendMode.srcIn,
            ),
            height: 20,
          ),
        ),
        title: Text(name, style: Styles.style16Medium()),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: ColorsManager.deepRed),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
