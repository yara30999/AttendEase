import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../app/app_prefs.dart';
import '../../../../../app/di.dart';
import '../../../../resourses/colors_manager.dart';

class ProgressCircle extends StatefulWidget {
  final DateTime? userCheckInTime;
  final DateTime groupCheckOutTime;

  const ProgressCircle({
    super.key,
    required this.groupCheckOutTime,
    this.userCheckInTime,
  });

  @override
  State<ProgressCircle> createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle> {
  Timer? _timer;
  double progress = 0.0;
  final AppPreferences _appPreferences = instance();

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _calculateProgress();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant ProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userCheckInTime != widget.userCheckInTime) {
      _appPreferences.setUserCheckInTime(widget.userCheckInTime);
      _calculateProgress();
      _startTimer();
    }
  }

  /// Loads stored check-in time when the app starts
  Future<void> _loadProgress() async {
    DateTime? storedCheckInTime = await _appPreferences.getUserCheckInTime();
    if (storedCheckInTime != null) {
      setState(() {
        _calculateProgress(storedCheckInTime);
      });
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

  void _calculateProgress([DateTime? storedCheckInTime]) async {
    DateTime? checkInTime = storedCheckInTime ?? widget.userCheckInTime;
    if (checkInTime == null) {
      setState(() {
        progress = 0.0;
      });
      return;
    }
    DateTime now = DateTime.now();
    // If current time is past checkout, reset progress and clear check-in time
    if (now.isAfter(widget.groupCheckOutTime)) {
      setState(() {
        progress = 0.0;
      });
      _timer?.cancel();
      // clear check-in time from shared-prefs
      await _appPreferences.setUserCheckInTime(null);
      // then if the user did not check-out , also save check-out time to the firebase
      // i still thinking how to do it (yara)
      return;
    }
    Duration totalDuration = widget.groupCheckOutTime.difference(checkInTime);
    Duration elapsed = now.difference(checkInTime);
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
