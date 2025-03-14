import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../app/extensions.dart';
import '../../../../../app/functions.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../resourses/colors_manager.dart';
import 'check_in_out_container.dart';
import 'progress_circle.dart';

class CheckInOutButton extends StatefulWidget {
  final GroupEntity groupEntity;
  const CheckInOutButton(this.groupEntity, {super.key});

  @override
  State<CheckInOutButton> createState() => _CheckInOutButtonState();
}

class _CheckInOutButtonState extends State<CheckInOutButton> {
  bool _isElevated = false; //not pressed at the first ;)

  void _onTap() async {
    setState(() {
      _isElevated = !_isElevated;
    });
    bool isAvailable = isWithinCheckInTime(widget.groupEntity);
    if (isAvailable) {
      print('yara this available time here ......');
      // TODO: Handle Check-in / Check-out logic
    } else {
      showToast(
        context.tr('outside_the_working_hours'),
        ColorsManager.softRed,
        Toast.LENGTH_LONG,
      );
    }
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) {
      setState(() => _isElevated = !_isElevated);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primary =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.paleCream
            : ColorsManager.grey;
    List<BoxShadow> darkShadows =
        _isElevated
            ? [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ]
            : [
              BoxShadow(
                color: Colors.grey[500]!,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ];
    List<BoxShadow> lightShadows =
        _isElevated
            ? [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.grey[400]!,
                offset: const Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ]
            : [
              BoxShadow(
                color: Colors.black87,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ];

    return GestureDetector(
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: _isElevated ? primary.withAlpha(200) : primary,
                shape: BoxShape.circle,
                boxShadow:
                    Theme.of(context).brightness == Brightness.light
                        ? lightShadows
                        : darkShadows,
              ),
              child: CheckInOutColumn(checkStatus: CheckStatus.checkIn),
            ),
            ProgressCircle(
              groupCheckOutTime: DateTime.now(),
              userCheckInTime: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
