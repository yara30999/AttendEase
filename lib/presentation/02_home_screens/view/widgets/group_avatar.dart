import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resourses/assets_manager.dart';
import '../../../resourses/colors_manager.dart';

class GroupAvatar extends StatelessWidget {
  final groupImage ;
  const GroupAvatar({super.key, this.groupImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          radius: 30,
          child: SvgPicture.asset(
            SvgAssets.group,
           fit: BoxFit.scaleDown,
            colorFilter: const ColorFilter.mode(
              ColorsManager.grey,
              BlendMode.srcIn,
            ),
            height: 60,
          ),
        );
  }
}