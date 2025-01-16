import 'package:flutter/material.dart';

import 'theme_extensions/page_link_extension.dart';

/// I copied this from the compass_app. IRL the AppTheme will be much smaller.
abstract final class AppTheme {
  static const _textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.blueAccent,
    ),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      // grey3 works for both light and dark themes
      color: AppColors.grey3,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: _textTheme.copyWith(
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    ),
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [PageLinkTheme(backgroundColor: Colors.grey.shade200)],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: _textTheme.copyWith(
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
    ),
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [PageLinkTheme(backgroundColor: Colors.grey.shade800)],
  );
}

abstract final class AppColors {
  static const black1 = Color(0xFF101010);
  static const white1 = Color(0xFFFFF7FA);
  static const grey1 = Color(0xFFF2F2F2);
  static const grey2 = Color(0xFF4D4D4D);
  static const grey3 = Color(0xFFA4A4A4);
  static const whiteTransparent = Color(
    0x4DFFFFFF,
  ); // Figma rgba(255, 255, 255, 0.3)
  static const blackTransparent = Color(0x4D000000);
  static const red1 = Color(0xFFE74C3C);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.black1,
    onPrimary: AppColors.white1,
    secondary: AppColors.black1,
    onSecondary: AppColors.white1,
    surface: Colors.white,
    onSurface: AppColors.black1,
    error: Colors.white,
    onError: Colors.red,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.white1,
    onPrimary: AppColors.black1,
    secondary: AppColors.white1,
    onSecondary: AppColors.black1,
    surface: AppColors.black1,
    onSurface: Colors.white,
    error: Colors.black,
    onError: AppColors.red1,
  );
}
