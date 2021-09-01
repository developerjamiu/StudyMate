import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/strings.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  static ThemeData _themeData(ColorScheme colorScheme) => ThemeData(
        primaryColor: colorScheme.primary,
        accentColor: colorScheme.secondary,
        backgroundColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        fontFamily: AppStrings.gilmerFont,
        textTheme: _textTheme(colorScheme),
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(iconTheme: _iconTheme(colorScheme)),
        iconTheme: _iconTheme(colorScheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      );

  static ColorScheme _lightColorScheme = ColorScheme.light().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    background: AppColors.backgroundColor,
    onBackground: AppColors.onBackgroundColor,
    onSurface: AppColors.onSurfaceColor,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        headline6: TextStyle(
          fontSize: 20,
          color: colorScheme.primary,
        ),
        bodyText1: TextStyle(fontSize: 14),
        // fontSize for TextField labels
        subtitle1: TextStyle(
          fontSize: 12,
        ),
        subtitle2: TextStyle(
          fontSize: 16,
        ),
        caption: TextStyle(
          fontSize: 10,
          color: colorScheme.onSurface,
        ),
        button: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      );

  static IconThemeData _iconTheme(ColorScheme colorScheme) =>
      IconThemeData(color: colorScheme.onSurface);
}
