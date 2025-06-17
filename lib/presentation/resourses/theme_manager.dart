import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors_manager.dart';
import 'styles_manager.dart';

ThemeData getlightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsManager.white,
    primaryColor: ColorsManager.emeraldGreen,

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.emeraldGreen,
      titleSpacing: 0,
      elevation: 0,
      shadowColor: ColorsManager.black,
      titleTextStyle: Styles.style20Bold(),
      toolbarTextStyle: Styles.style20Bold(),
      iconTheme: const IconThemeData(color: ColorsManager.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Status bar color
        statusBarIconBrightness: Brightness.dark, // black icons
        statusBarBrightness: Brightness.light, // For iOS dark background
      ),
    ),

    // text selection theme
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorsManager.emeraldGreen,
      selectionColor: ColorsManager.grey,
      // Change the handle to blue for the text form field ;)
      selectionHandleColor: ColorsManager.emeraldGreen,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //side: const BorderSide(color: ColorsManager.blue, width: 2),
        elevation: 0,
        iconColor: ColorsManager.white,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.emeraldGreen,
        textStyle: Styles.style20Bold(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    ),

    // floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 24,
      foregroundColor: ColorsManager.paleCream,
      backgroundColor: ColorsManager.deepRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(color: ColorsManager.deepRed, width: 4),
      ),
    ),

    // card theme
    cardTheme: CardThemeData(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      color: ColorsManager.creamyBeige,
      shadowColor: ColorsManager.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    //divider theme
    dividerTheme: const DividerThemeData(
      color: ColorsManager.grey,
      thickness: 2,
    ),

    // text form field theme
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(16),
      hintStyle: Styles.style16Medium(),
      errorStyle: Styles.style12Medium().copyWith(color: ColorsManager.red),
      labelStyle: Styles.style16Medium().copyWith(
        color: ColorsManager.emeraldGreen,
      ),
      suffixIconColor: ColorsManager.grey,
      prefixIconColor: ColorsManager.emeraldGreen,
      //default border
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.emeraldGreen, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.emeraldGreen, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.emeraldGreen, width: 2),
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

    // text button theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ColorsManager.mutedRed),
        textStyle: WidgetStateProperty.all<TextStyle>(
          Styles.style16Medium().copyWith(
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
            color: ColorsManager.mutedRed,
          ),
        ),
      ),
    ),

    // radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        return ColorsManager.grey;
      }),
    ),

    //tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: ColorsManager.white,
      labelStyle: Styles.style14Medium().copyWith(fontWeight: FontWeight.bold),
      unselectedLabelColor: ColorsManager.black,
      unselectedLabelStyle: Styles.style14Medium(),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.transparent,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ColorsManager.black,
      ),
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),

    //bottom sheet theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorsManager.softBeige,
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsManager.black,
    primaryColor: ColorsManager.mutedRed,

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.mutedRed,
      titleSpacing: 0,
      elevation: 0,
      shadowColor: ColorsManager.paleBlushRed,
      titleTextStyle: Styles.style20Bold(),
      toolbarTextStyle: Styles.style20Bold(),
      iconTheme: const IconThemeData(color: ColorsManager.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Status bar color
        statusBarIconBrightness: Brightness.dark, // black icons
        statusBarBrightness: Brightness.light, // For iOS dark background
      ),
    ),

    // text selection theme
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorsManager.mutedRed,
      selectionColor: ColorsManager.grey,
      // Change the handle to mediumBrown for the text form field ;)
      selectionHandleColor: ColorsManager.mutedRed,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //side: const BorderSide(color: ColorsManager.blue, width: 2),
        elevation: 0,
        iconColor: ColorsManager.white,
        foregroundColor: ColorsManager.white,
        backgroundColor: ColorsManager.mutedRed,
        textStyle: Styles.style20Bold(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    ),

    // floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 24,
      foregroundColor: ColorsManager.black,
      backgroundColor: ColorsManager.paleCream,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(color: ColorsManager.paleCream, width: 4),
      ),
    ),

    // card theme
    cardTheme: CardThemeData(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      color: ColorsManager.grey,
      shadowColor: ColorsManager.emeraldGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    //divider theme
    dividerTheme: const DividerThemeData(
      color: ColorsManager.paleBlushRed,
      thickness: 2,
    ),

    // text form field theme
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(16),
      hintStyle: Styles.style16Medium(),
      errorStyle: Styles.style12Medium().copyWith(color: ColorsManager.red),
      labelStyle: Styles.style16Medium().copyWith(
        color: ColorsManager.paleBlushRed,
      ),
      suffixIconColor: ColorsManager.grey,
      prefixIconColor: ColorsManager.paleBlushRed,
      //default border
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.paleBlushRed, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.paleBlushRed, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.paleBlushRed, width: 2),
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

    // text button theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ColorsManager.grey),
        textStyle: WidgetStateProperty.all<TextStyle>(
          Styles.style16Medium().copyWith(
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
            color: ColorsManager.grey,
          ),
        ),
      ),
    ),

    // radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        return ColorsManager.grey;
      }),
    ),

    //tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: ColorsManager.white,
      labelStyle: Styles.style14Medium().copyWith(fontWeight: FontWeight.bold),
      unselectedLabelColor: ColorsManager.black,
      unselectedLabelStyle: Styles.style14Medium(),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.transparent,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ColorsManager.black,
      ),
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),

    //bottom sheet theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorsManager.black,
    ),
  );
}
