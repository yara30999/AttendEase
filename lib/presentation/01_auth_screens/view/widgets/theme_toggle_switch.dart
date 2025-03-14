import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as dui;
import '../../../../app/functions.dart';
import '../../../02_home_screens/view_model/theme_bloc/theme_bloc.dart';
import '../../../resourses/colors_manager.dart';

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = context.watch<ThemeBloc>().state.themeMode;
    Color mainColor =
        isLightTheme(context)
            ? ColorsManager.emeraldGreen
            : ColorsManager.mutedRed;
    return Directionality(
      textDirection: dui.TextDirection.ltr,
      child: AnimatedToggleSwitch<bool>.rolling(
        // if the current == true , so it will select the true item which is light theme
        current: themeMode == ThemeMode.light,
        // light theme => true , dark theme => false , as 0 & 1
        values: const [true, false],
        iconOpacity:
            1, //showing the exact color of unselected items without opacity
        height: 30.0, //total height
        indicatorSize: const Size.fromWidth(30.0), //indicator width & height
        spacing: 10, // between each item in the switch
        borderWidth: 2.0,
        style: ToggleStyle(
          borderColor: mainColor, // Custom border color
          backgroundColor: Colors.transparent,
          indicatorBorder: Border.all(color: mainColor, width: 2),
          indicatorColor: mainColor,
        ),
        iconBuilder: (value, foreground) {
          return value
              ? Icon(
                Icons.sunny,
                color: foreground ? ColorsManager.white : mainColor,
              )
              : Icon(
                Icons.nightlight_round,
                color: foreground ? ColorsManager.white : mainColor,
              );
        },
        onChanged: (value) {
          context.read<ThemeBloc>().add(ToggleTheme());
        },
      ),
    );
  }
}
