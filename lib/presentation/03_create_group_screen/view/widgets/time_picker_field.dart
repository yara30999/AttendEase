import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../02_home_screens/view_model/theme_bloc/theme_bloc.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class TimePickerField extends StatelessWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimePickerField({
    Key? key,
    required this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = context.watch<ThemeBloc>().state.themeMode;
    Color mainColor =
        themeMode == ThemeMode.light
            ? ColorsManager.emeraldGreen
            : ColorsManager.paleBlushRed;
    return InkWell(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (picked != null) {
          onTimeSelected(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(initialTime.format(context), style: Styles.style16Medium()),
            Icon(Icons.access_time, color: mainColor),
          ],
        ),
      ),
    );
  }
}
