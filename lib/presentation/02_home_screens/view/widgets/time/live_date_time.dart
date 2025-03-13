import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../resourses/styles_manager.dart';

class LiveDateTime extends StatefulWidget {
  final Color? textColor;
  const LiveDateTime({super.key, this.textColor});

  @override
  State<LiveDateTime> createState() => _LiveDateTimeState();
}

class _LiveDateTimeState extends State<LiveDateTime> {
  late Timer _timer;
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        _currentDate = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('MMM dd, yyyy - EEEE').format(_currentDate.toLocal()),
      style: Styles.style24Bold().copyWith(color: widget.textColor),
    );
  }
}
