import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../app/functions.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../resourses/assets_manager.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';

class PermissionBtn extends StatelessWidget {
  final GroupEntity groupEntity;
  const PermissionBtn(this.groupEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          showTakePermissionBottomSheet(context, groupEntity);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SvgAssets.havePermission,
              fit: BoxFit.scaleDown,
              height: 30,
              colorFilter: ColorFilter.mode(
                ColorsManager.white,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 20),
            Text(context.tr('HavePermission'), style: Styles.style18Medium()),
          ],
        ),
      ),
    );
  }
}
