import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../app/app_prefs.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final AppPreferences _appPreferences;
  ThemeBloc(this._appPreferences) : super(const ThemeLight()) {
    on<ToggleTheme>(onToggleTheme);
    on<LoadTheme>(onLoadTheme);
  }

  FutureOr<void> onLoadTheme(event, emit) async {
    final themeMode = await _appPreferences.getTheme();
    if (themeMode == ThemeMode.dark) {
      emit(const ThemeDark());
    } else {
      emit(const ThemeLight());
    }
  }

  FutureOr<void> onToggleTheme(event, emit) async {
    if (state is ThemeLight) {
      emit(const ThemeDark());
      await _appPreferences.setTheme(state.themeMode);
    } else {
      emit(const ThemeLight());
      await _appPreferences.setTheme(state.themeMode);
    }
  }
}
