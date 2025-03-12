import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({super.key});

  @override
  TimeCardState createState() => TimeCardState();
}

class TimeCardState extends State<TimeCard> {
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
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,
      child: Card(
        elevation: 4,
        color:
            Theme.of(context).brightness == Brightness.light
                ? ColorsManager.paleCream
                : ColorsManager.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.watch_later,
                size: 50,
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? ColorsManager.emeraldGreen
                        : ColorsManager.mutedRed,
              ),
              SizedBox(width: 10),
              Text(
                DateFormat('hh : mm a').format(_currentTime.toLocal()),
                style: Styles.style24Bold(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
