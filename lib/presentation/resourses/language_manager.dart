import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum LanguageType { english, arabic }

class LocalizationUtils {
  static const Locale arabicLocal = Locale('ar', 'EG');
  static const Locale englishLocal = Locale('en', 'US');

  static bool isCurrentLocalAr(BuildContext context) {
    return EasyLocalization.of(context)!.currentLocale!.languageCode ==
        LanguageType.arabic.getCode();
    // another way to do that is
    //return context.locale.languageCode == LanguageType.arabic.getCode();
  }
}

extension LanguageTypeExtension on LanguageType {
  String getCode() {
    switch (this) {
      case LanguageType.english:
        return LocalizationUtils.englishLocal.languageCode;
      case LanguageType.arabic:
        return LocalizationUtils.arabicLocal.languageCode;
    }
  }

  String getCountryCode() {
    switch (this) {
      case LanguageType.english:
        return LocalizationUtils.englishLocal.countryCode.toString();
      case LanguageType.arabic:
        return LocalizationUtils.arabicLocal.countryCode.toString();
    }
  }
}
