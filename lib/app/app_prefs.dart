import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'extensions.dart';

const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String prefsKeyTheme = "PREFS_KEY_THEME";
const String prefsKeyIsUserRole = "PREFS_KEY_IS_USER_ROLE";

abstract class AppPreferences {
  Future<String> getAppThemeName();
  Future<void> setTheme(ThemeMode theme);
  Future<ThemeMode> getTheme();
  Future<void> setUserLoggedIn();
  bool isUserLoggedIn();
  Future<void> setUserRole(Role role);
  String getUserRole();
  Future<void> removePrefs();
}

class AppPreferencesImpl implements AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferencesImpl(this._sharedPreferences);

  // ############################################################# theme
  @override
  Future<String> getAppThemeName() async {
    String? themeName = _sharedPreferences.getString(prefsKeyTheme);
    if (themeName != null && themeName.isNotEmpty) {
      return themeName;
    } else {
      // return default theme
      return ThemeMode.light.getName();
    }
  }

  @override
  Future<void> setTheme(ThemeMode theme) async {
    if (theme == ThemeMode.light) {
      _sharedPreferences.setString(prefsKeyTheme, ThemeMode.light.getName());
    } else if (theme == ThemeMode.dark) {
      _sharedPreferences.setString(prefsKeyTheme, ThemeMode.dark.getName());
    } else {
      _sharedPreferences.setString(prefsKeyTheme, ThemeMode.system.getName());
    }
  }

  @override
  Future<ThemeMode> getTheme() async {
    String currentThemeName = await getAppThemeName();

    if (currentThemeName == ThemeMode.light.getName()) {
      return ThemeMode.light;
    } else if (currentThemeName == ThemeMode.dark.getName()) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  // ############################################################# user logged in
  @override
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  @override
  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  // ############################################################# user logged role
  @override
  Future<void> setUserRole(Role role) async {
    _sharedPreferences.setString(prefsKeyIsUserRole, role.name);
  }

  @override
  String getUserRole() {
    return _sharedPreferences.getString(prefsKeyIsUserRole) ?? Role.admin.name;
  }

  // ############################################################# remove all prefs
  @override
  Future<void> removePrefs() async {
    _sharedPreferences.remove(prefsKeyTheme);
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
    _sharedPreferences.remove(prefsKeyIsUserRole);
  }
}
