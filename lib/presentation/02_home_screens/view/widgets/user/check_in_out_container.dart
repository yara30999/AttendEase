import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../app/extensions.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';

class CheckInOutColumn extends StatelessWidget {
  final CheckStatus checkStatus;
  const CheckInOutColumn({super.key, required this.checkStatus});

  @override
  Widget build(BuildContext context) {
    Color color =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.emeraldGreen
            : ColorsManager.deepRed;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              checkStatus.svg,
              fit: BoxFit.scaleDown,
              height: 50,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            Text(
              checkStatus.string,
              style: Styles.style24Bold().copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}
