import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../app/extensions.dart';
import '../../../../resourses/assets_manager.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';

class GroupCheckDetails extends StatelessWidget {
  final DateTime checkInTime;
  final DateTime checkOutTime;
  const GroupCheckDetails({
    super.key,
    required this.checkInTime,
    required this.checkOutTime,
  });

  @override
  Widget build(BuildContext context) {
    int differenceHours = checkOutTime.difference(checkInTime).inHours;
    Color primaryColor =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.emeraldGreen
            : ColorsManager.mutedRed;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                SvgAssets.checkInHour,
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              Text(context.tr('CheckIn'), style: Styles.style14Medium()),
              Text(
                checkInTime.toFormattedTime(),
                style: Styles.style14Medium(),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                SvgAssets.checkOutHour,
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              Text(context.tr('CheckOut'), style: Styles.style14Medium()),
              Text(
                checkOutTime.toFormattedTime(),
                style: Styles.style14Medium(),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                SvgAssets.totalHour,
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              Text(context.tr('total'), style: Styles.style14Medium()),
              Text(
                '$differenceHours ${context.tr('hours')}',
                style: Styles.style14Medium(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
