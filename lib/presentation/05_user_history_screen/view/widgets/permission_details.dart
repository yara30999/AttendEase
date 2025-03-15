import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/extensions.dart';
import '../../../../domain/entities/permission_entity.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class PermissionDetails extends StatelessWidget {
  final PermissionEntity pemissionData;

  const PermissionDetails({Key? key, required this.pemissionData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              pemissionData.type.string, // Using the extension
              style: Styles.style16Medium().copyWith(
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? ColorsManager.deepRed
                        : ColorsManager.darkTeal,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('EEEE, MMMM d, y').format(pemissionData.date),
              style: Styles.style14Medium().copyWith(
                color: ColorsManager.black,
              ),
            ),
            Offstage(
              offstage: pemissionData.message == null,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.50,
                child: Text(
                  pemissionData.message!,
                  style: Styles.style14Medium().copyWith(
                    color: ColorsManager.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        pemissionData.type.icon, // Using the extension
      ],
    );
  }
}
