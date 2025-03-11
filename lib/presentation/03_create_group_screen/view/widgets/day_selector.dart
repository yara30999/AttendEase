import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';

class DaySelector extends StatelessWidget {
  final Set<int> selectedDays;
  final Function(int)? onDaySelected;

  const DaySelector({Key? key, required this.selectedDays, this.onDaySelected})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor =
        Theme.of(context).brightness == Brightness.light
            ? ColorsManager.emeraldGreen
            : ColorsManager.paleBlushRed;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final dayName = _getDayName(index);
        final isSelected = selectedDays.contains(index);
        return GestureDetector(
          onTap: onDaySelected == null ? null : () => onDaySelected!(index),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? mainColor : Colors.transparent,
              border: Border.all(color: mainColor, width: 2),
            ),
            child: Center(
              child: Text(
                dayName,
                style: TextStyle(
                  color: isSelected ? Colors.white : mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'Sun'.tr();
      case 1:
        return 'Mon'.tr();
      case 2:
        return 'Tue'.tr();
      case 3:
        return 'Wed'.tr();
      case 4:
        return 'Thu'.tr();
      case 5:
        return 'Fri'.tr();
      case 6:
        return 'Sat'.tr();
      default:
        return '';
    }
  }
}
