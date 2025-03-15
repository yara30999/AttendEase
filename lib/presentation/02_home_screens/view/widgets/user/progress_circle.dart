import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../resourses/colors_manager.dart';

class ProgressCircle extends StatefulWidget {
  final DateTime? userCheckInTime;
  final GroupEntity groupEntity;

  const ProgressCircle({
    super.key,
    required this.groupEntity,
    this.userCheckInTime,
  });

  @override
  State<ProgressCircle> createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle> {
  Timer? _timer;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateProgress();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant ProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userCheckInTime != widget.userCheckInTime) {
      _calculateProgress();
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any previous timer
    if (widget.userCheckInTime != null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _calculateProgress();
      });
    }
  }

  void _calculateProgress() async {
    DateTime? checkInTime = widget.userCheckInTime;
    if (checkInTime == null) {
      setState(() {
        progress = 0.0;
      });
      return;
    }
    DateTime now = DateTime.now();
    // Normalize `now`, `checkInTime`, and `checkOut` to ignore the date & and care only about hours...
    DateTime todayCheckIn = DateTime(
      now.year,
      now.month,
      now.day,
      checkInTime.hour,
      checkInTime.minute,
    );
    DateTime todayCheckOut = DateTime(
      now.year,
      now.month,
      now.day,
      widget.groupEntity.checkOut.hour,
      widget.groupEntity.checkOut.minute,
    );
    // If now is after checkOut, set progress to 1.0
    if (now.isAfter(todayCheckOut)) {
      setState(() {
        progress = 1.0;
      });
      _timer?.cancel();
      return;
    }
    // Calculate elapsed and total durations
    Duration totalDuration = todayCheckOut.difference(todayCheckIn);
    Duration elapsed = now.difference(todayCheckIn);
    // Compute progress
    double newProgress = elapsed.inSeconds / totalDuration.inSeconds;
    newProgress = newProgress.clamp(0.0, 1.0);
    setState(() {
      progress = newProgress;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primary =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.paleCream
            : ColorsManager.grey;
    Color secondary =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.emeraldGreen
            : ColorsManager.deepRed;
    return SizedBox(
      width: 200,
      height: 200,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: 10,
        backgroundColor: primary,
        valueColor: AlwaysStoppedAnimation<Color>(secondary),
      ),
    );
  }
}
