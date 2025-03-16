import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../app/extensions.dart';
import '../../../../../app/functions.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../view_model/check_in_out_bloc/check_in_out_bloc.dart';
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

    return BlocConsumer<CheckInOutBloc, CheckInOutState>(
      listener: (context, state) {
        if (state is CheckInOutSuccess) {
          if (state.checkStatus == CheckStatus.checkOut) {
            showToast(
              context.tr('check_in_successfully'),
              ColorsManager.grey,
              Toast.LENGTH_LONG,
            );
          } else {
            showToast(
              context.tr('check_out_successfully'),
              ColorsManager.grey,
              Toast.LENGTH_LONG,
            );
          }
        }
        if (state is CheckInOutError) {
          showToast(state.errMessage, ColorsManager.softRed, Toast.LENGTH_LONG);
        }
      },
      builder: (context, state) {
        if (state is CheckInOutLoading) {
          return GestureDetector(
            onTap: () {
              if (state.checkStatus == CheckStatus.checkIn) {
                showToast(
                  context.tr('wait_check_in_processing'),
                  ColorsManager.grey,
                );
              } else {
                showToast(
                  context.tr('wait_check_out_processing'),
                  ColorsManager.grey,
                );
              }
            },
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
                    child: CheckInOutColumn(checkStatus: state.checkStatus),
                  ),
                  ProgressCircle(
                    groupEntity: widget.groupEntity,
                    userCheckInTime: state.checkInTime,
                  ),
                ],
              ),
            ),
          );
        }
        return GestureDetector(
          onTap: () async {
            setState(() {
              _isElevated = !_isElevated;
            });
            if (context.read<CheckInOutBloc>().isTryingToCheckIn) {
              //check-in process triggering
              context.read<CheckInOutBloc>().add(
                CheckInRequested(groupEntity: widget.groupEntity),
              );
            } else {
              //check-out process triggering
              context.read<CheckInOutBloc>().add(
                CheckOutRequested(groupEntity: widget.groupEntity),
              );
            }
            await Future.delayed(const Duration(milliseconds: 250));
            if (mounted) {
              setState(() => _isElevated = !_isElevated);
            }
          },
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
                  child: CheckInOutColumn(checkStatus: state.checkStatus),
                ),
                ProgressCircle(
                  groupEntity: widget.groupEntity,
                  userCheckInTime: state.checkInTime,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
