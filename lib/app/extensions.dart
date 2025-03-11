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
    //for firebase constants....
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

  PermissionType getPermissionType() {
    if (this == null) {
      return PermissionType.sickLeave;
    } else {
      switch (this) {
        case AppConstants.sickLeave:
          return PermissionType.sickLeave;
        case AppConstants.emergencyLeave:
          return PermissionType.emergencyLeave;
        case AppConstants.vacationLeave:
          return PermissionType.vacationLeave;
        case AppConstants.workFromHome:
          return PermissionType.workFromHome;
        default:
          return PermissionType.sickLeave;
      }
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

extension TimeOfDayExtensions on TimeOfDay {
  DateTime toDateTime({DateTime? baseDate}) {
    final now = baseDate ?? DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}

enum PermissionType { sickLeave, emergencyLeave, vacationLeave, workFromHome }

extension PermissionTypeExtension on PermissionType {
  String get name {
    //for firebase constants....
    switch (this) {
      case PermissionType.sickLeave:
        return AppConstants.sickLeave;
      case PermissionType.emergencyLeave:
        return AppConstants.emergencyLeave;
      case PermissionType.vacationLeave:
        return AppConstants.vacationLeave;
      case PermissionType.workFromHome:
        return AppConstants.workFromHome;
    }
  }

  String get string {
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
          child: const Icon(Icons.healing, color: Colors.white, size: 24),
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
          child: const Icon(Icons.beach_access, color: Colors.white, size: 24),
        );
      case PermissionType.workFromHome:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF81C784), // Light green
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.home_work, color: Colors.white, size: 24),
        );
    }
  }
}

enum Status { checkIn, checkOut , havePermission }

extension StatusExtension on Status {
  String get name {
    switch (this) {
      case Status.checkIn:
        return 'CheckIn'.tr(); 
      case Status.checkOut:
        return 'CheckOut'.tr();
      case Status.havePermission:
        return 'HavePermission'.tr();  
    }
  }

  String get svg {
    switch (this) {
      case Status.checkIn:
        return SvgAssets.checkIn;
      case Status.checkOut:
        return SvgAssets.checkOut;
      case Status.havePermission:
        return SvgAssets.havePermission;  
    }
  }
}