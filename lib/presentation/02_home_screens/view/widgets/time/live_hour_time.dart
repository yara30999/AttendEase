import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../resourses/styles_manager.dart';

class LiveHourTime extends StatefulWidget {
  const LiveHourTime({super.key});

  @override
  State<LiveHourTime> createState() => _LiveHourTimeState();
}

class _LiveHourTimeState extends State<LiveHourTime> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
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
      DateFormat('hh : mm a').format(_currentTime.toLocal()),
      style: Styles.style24Bold(),
    );
  }
}
