import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../presentation/resourses/assets_manager.dart';
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

  String get svg {
    switch (this) {
      case Role.admin:
        return SvgAssets.admin;
      case Role.user:
        return SvgAssets.user;
    }
  }

  String get string {
    switch (this) {
      case Role.admin:
        return "admin".tr();
      case Role.user:
        return "user".tr();
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

enum PermissionType {
  sickLeave,
  emergencyLeave,
  vacationLeave,
  workFromHome
}

extension PermissionTypeExtension on PermissionType {
  String get name {
    switch (this) {
      case PermissionType.sickLeave:
        return 'Sick Leave'.tr();
      case PermissionType.emergencyLeave:
        return 'Emergency Leave'.tr();
      case PermissionType.vacationLeave:
        return 'Vacation Leave'.tr();
      case PermissionType.workFromHome:
        return 'Work From Home'.tr();
    }
  }

  Widget get icon {
    switch (this) {
      case PermissionType.sickLeave:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFB5B5), // Light pink
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.healing,
            color: Colors.white,
            size: 24,
          ),
        );
      case PermissionType.emergencyLeave:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107), // Warning yellow
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 24,
          ),
        );
      case PermissionType.vacationLeave:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF90CAF9), // Light blue
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.beach_access,
            color: Colors.white,
            size: 24,
          ),
        );
      case PermissionType.workFromHome:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF81C784), // Light green
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.home_work,
            color: Colors.white,
            size: 24,
          ),
        );
    }
  }
}


