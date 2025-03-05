import 'package:flutter/material.dart';
import '../presentation/resourses/constant_manager.dart';

const String light = "light_theme";
const String dark = "dark_theme";
const String system = "system_theme";

extension LanguageTypeExtension on ThemeMode {
  String getName() {
    switch (this) {
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
      case ThemeMode.system:
        return system;
    }
  }
}

enum Role { admin, user }

extension RoleExtension on Role {
  String get name {
    switch (this) {
      case Role.admin:
        return AppConstants.admin;
      case Role.user:
        return AppConstants.user;
    }
  }
}

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return AppConstants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return AppConstants.zero;
    } else {
      return this!;
    }
  }
}
