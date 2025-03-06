import 'package:flutter/material.dart';

class DayIndicator extends StatelessWidget {
  final String day;
  final bool isActive;

  const DayIndicator({
    Key? key,
    required this.day,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? Theme.of(context).primaryColor
            : Colors.transparent,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: isActive
                ? Colors.white
                : Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}