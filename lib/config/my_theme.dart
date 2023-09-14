import 'package:flutter/material.dart';
import 'package:food_app_panel/config/my_colors.dart';

class AppTheme {
  static const primaryColor = Color.fromARGB(255, 106, 49, 185);

  static ColorScheme fromBrightnesslight() {
    return ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: primaryColor,
      background: whitecolors,
      primaryContainer: lightBgColor,
      secondaryContainer: lightSecWidgetColor,
    );
  }

  static ColorScheme fromBrightnessdark() {
    return ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: primaryColor,
      background: darkBgColor,
      primaryContainer: darkWidgetColor,
      secondaryContainer: darkSecWidgetColor,
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: lightWidgetColor,
      )),
      appBarTheme: const AppBarTheme(backgroundColor: lightWidgetColor),
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightnesslight(),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: darkWidgetColor,
      )),
      appBarTheme: const AppBarTheme(backgroundColor: darkBgColor),
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightnessdark(),
    );
  }
}
