import 'package:flutter/material.dart';

import 'theme_extensions/page_link_extension.dart';

/// I copied this from the compass_app. IRL the AppTheme will be much smaller.
abstract final class AppTheme {
  static const serifTitle = TextStyle(
    fontFamily: 'Linux Libertine',
    fontFamilyFallback: ['Georgia', 'Times', 'Source Serif Pro', 'serif'],
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const timelineEntryTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static const _textTheme = TextTheme(
    /// Default text
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),

    /// Used for labels and captions
    labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.grey3,
    ),
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
    textTheme: _textTheme,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [PageLinkTheme(backgroundColor: Colors.grey.shade200)],
  );

  static ThemeData darkTheme = ThemeData(
    textTheme: _textTheme,
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [PageLinkTheme(backgroundColor: Colors.grey.shade800)],
  );
}

abstract final class AppColors {
  static const black1 = Color(0xFF101010);
  static const white1 = Color(0xFFFFF7FA);
  static const grey1 = Color(0xFFF8F8F8);
  static const grey2 = Color(0xFFEEEEEE);
  static const grey3 = Color(0xFF4D4D4D);
  static const grey4 = Color(0xFFA4A4A4);
  static const lightBackground = Color(0xFFf6f8fc);
  static const whiteTransparent = Color(
    0x4DFFFFFF,
  ); // Figma rgba(255, 255, 255, 0.3)
  static const blackTransparent = Color(0x4D000000);
  static const red1 = Color(0xFFE74C3C);
  static const primary = Color.fromRGBO(4, 104, 215, 1);
  static const primaryOpaque = Color.fromRGBO(4, 104, 215, .3);
  static const primaryLight = Color.fromRGBO(214, 226, 243, 1.0);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: AppColors.black1,
    secondary: AppColors.primaryLight,
    onSecondary: AppColors.white1,
    surface: AppColors.lightBackground,
    onSurface: AppColors.black1,
    error: Colors.white,
    onError: Colors.red,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.white1,
    onPrimary: AppColors.black1,
    secondary: AppColors.grey2,
    onSecondary: AppColors.black1,
    surface: AppColors.black1,
    onSurface: Colors.white,
    error: Colors.black,
    onError: AppColors.red1,
  );
}

abstract final class Dimensions {
  const Dimensions();

  static const double radius = 4;
}
