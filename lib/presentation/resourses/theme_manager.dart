import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors_manager.dart';
import 'styles_manager.dart';

ThemeData getlightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsManager.white,
    primaryColor: ColorsManager.mediumBrown,

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.oliveGreen,
      titleSpacing: 0,
      elevation: 0,
      shadowColor: ColorsManager.black,
      titleTextStyle: Styles.style20Bold(),
      toolbarTextStyle: Styles.style20Bold(),
      iconTheme: const IconThemeData(color: ColorsManager.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.oliveGreen, // Status bar color
        statusBarIconBrightness: Brightness.dark, // black icons
        statusBarBrightness: Brightness.light, // For iOS dark background
      ),
    ),

    // text selection theme
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorsManager.darkGreen,
      selectionColor: ColorsManager.grey,
      // Change the handle to blue for the text form field ;)
      selectionHandleColor: ColorsManager.darkGreen,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //side: const BorderSide(color: ColorsManager.blue, width: 2),
        elevation: 0,
        iconColor: ColorsManager.white,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.mediumGreen,
        textStyle: Styles.style20Bold(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    ),

    // card theme
    cardTheme: CardTheme(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      color: ColorsManager.creamyBeige,
      shadowColor: ColorsManager.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    //divider theme
    dividerTheme: const DividerThemeData(
      color: ColorsManager.black,
      thickness: 2,
    ),

    // text form field theme
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(16),
      hintStyle: Styles.style16Medium(),
      errorStyle: Styles.style12Medium().copyWith(color: ColorsManager.red),
      labelStyle: Styles.style16Medium().copyWith(
        color: ColorsManager.darkGreen,
      ),
      suffixIconColor: ColorsManager.lightOrange,
      prefixIconColor: ColorsManager.darkGreen,
      //default border
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.darkGreen, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.darkGreen, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.darkGreen, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // error border style
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.red, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // focused border style
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.red, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsManager.black,
    primaryColor: ColorsManager.mediumBrown,

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.oliveGreen,
      titleSpacing: 0,
      elevation: 0,
      shadowColor: ColorsManager.goldenSand,
      titleTextStyle: Styles.style20Bold(),
      toolbarTextStyle: Styles.style20Bold(),
      iconTheme: const IconThemeData(color: ColorsManager.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.oliveGreen, // Status bar color
        statusBarIconBrightness: Brightness.dark, // black icons
        statusBarBrightness: Brightness.light, // For iOS dark background
      ),
    ),

    // text selection theme
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorsManager.mediumBrown,
      selectionColor: ColorsManager.grey,
      // Change the handle to mediumBrown for the text form field ;)
      selectionHandleColor: ColorsManager.mediumBrown,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //side: const BorderSide(color: ColorsManager.blue, width: 2),
        elevation: 0,
        iconColor: ColorsManager.white,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.mediumGreen,
        textStyle: Styles.style20Bold(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    ),

    // card theme
    cardTheme: CardTheme(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      color: ColorsManager.mediumBrown,
      shadowColor: ColorsManager.goldenSand,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    //divider theme
    dividerTheme: const DividerThemeData(
      color: ColorsManager.white,
      thickness: 2,
    ),

    // text form field theme
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(16),
      hintStyle: Styles.style16Medium(),
      errorStyle: Styles.style12Medium().copyWith(color: ColorsManager.red),
      labelStyle: Styles.style16Medium().copyWith(
        color: ColorsManager.lightOrange,
      ),
      suffixIconColor: ColorsManager.white,
      prefixIconColor: ColorsManager.lightOrange,
      //default border
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.lightOrange, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.lightOrange, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.lightOrange, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // error border style
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.red, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // focused border style
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.red, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    ),
  );
}
