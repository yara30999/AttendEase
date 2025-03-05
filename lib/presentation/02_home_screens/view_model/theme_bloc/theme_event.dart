part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class LoadTheme extends ThemeEvent {}
