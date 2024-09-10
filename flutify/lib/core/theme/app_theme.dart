import 'package:flutify/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static OutlineInputBorder _borderGen(Color borderColor) => OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      );

  static ThemeData darkAppTheme = ThemeData(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(17),
        hintStyle: const TextStyle(
          color: Pallete.greyColor,
        ),
        enabledBorder: _borderGen(Pallete.borderColor),
        focusedBorder: _borderGen(Pallete.gradient3),
        errorBorder: _borderGen(Pallete.errorColor),
        focusedErrorBorder: _borderGen(Pallete.errorColor)),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Pallete.gradient2,
        padding: const EdgeInsets.all(0),
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
        textStyle: const TextStyle(fontSize: 13),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Pallete.whiteColor,
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: Pallete.whiteColor, fontSize: 13),
    ),
  );
}
