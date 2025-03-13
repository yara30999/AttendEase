import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../app/extensions.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';

class CheckInOutContainer extends StatelessWidget {
  final CheckStatus checkStatus;
  const CheckInOutContainer({super.key, required this.checkStatus});

  @override
  Widget build(BuildContext context) {
    Color primary =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.paleCream
            : ColorsManager.grey;
    Color secondery =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.emeraldGreen
            : ColorsManager.deepRed;
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                checkStatus.svg,
                fit: BoxFit.scaleDown,
                height: 50,
                colorFilter: ColorFilter.mode(secondery, BlendMode.srcIn),
              ),
              Text(
                checkStatus.string,
                style: Styles.style24Bold().copyWith(color: secondery),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
