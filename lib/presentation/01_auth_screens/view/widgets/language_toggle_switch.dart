import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/functions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/language_manager.dart';
import 'dart:ui' as dui;

class LanguageToggleSwitch extends StatelessWidget {
  const LanguageToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    Color mainColor =
        isLightTheme(context)
            ? ColorsManager.emeraldGreen
            : ColorsManager.mutedRed;
    return Directionality(
      textDirection: dui.TextDirection.ltr,
      child: AnimatedToggleSwitch<bool>.rolling(
        // current == true so its english , current == false so its arabic
        current: !LocalizationUtils.isCurrentLocalAr(context),
        // english => true , arabic => false , as 0 & 1
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
              ? CountryFlag.fromCountryCode(
                LanguageType.english.getCountryCode(),
                shape: const Circle(),
                height: 20,
                width: 20,
              )
              : CountryFlag.fromCountryCode(
                LanguageType.arabic.getCountryCode(),
                shape: const Circle(),
                height: 20,
                width: 20,
              );
        },
        onChanged: (value) {
          value
              ? context.setLocale(LocalizationUtils.englishLocal)
              : context.setLocale(LocalizationUtils.arabicLocal);
        },
      ),
    );
  }
}
