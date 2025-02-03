import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/page_link_extension.dart';

abstract final class AppTheme {
  // Map Cupertino data to a Material ThemeData object
  static ThemeData cupertinoLightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.cupertinoScaffoldBackgroundColor,
    primaryColor: AppColors.primary,
    textTheme: cupertinoTextTheme,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: Colors.white,
      onPrimaryContainer: AppColors.labelOnLight,
      shadow: Colors.black12,
    ),
    extensions: <ThemeExtension<PageLinkTheme>>[
      PageLinkTheme(backgroundColor: Colors.grey.shade200),
    ],
  );

  static ThemeData materialLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: materialTextTheme,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: Colors.white,
      onPrimaryContainer: AppColors.labelOnLight,
      shadow: Colors.black12,
    ),
    scaffoldBackgroundColor: AppColors.materialScaffoldBackgroundColor,
    extensions: <ThemeExtension<PageLinkTheme>>[
      PageLinkTheme(backgroundColor: Colors.grey.shade200),
    ],
  );

  // Used to create Cupertino text styles
  static const CupertinoThemeData _cupertinoLightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
  );

  // Map cupertino styles to MaterialTheme naming convention
  static TextTheme cupertinoTextTheme = TextTheme(
    headlineLarge: AppTheme
        ._cupertinoLightTheme
        .textTheme
        .navLargeTitleTextStyle
        .copyWith(letterSpacing: -1.5, fontSize: 32),
    titleLarge: AppTheme._cupertinoLightTheme.textTheme.navTitleTextStyle
        .copyWith(
          fontSize: 22,
          fontFamily: 'Linux Libertine',
          fontFamilyFallback: <String>[
            'Georgia',
            'Times',
            'Source Serif Pro',
            'serif',
          ],
        ),
    titleMedium: AppTheme._cupertinoLightTheme.textTheme.navTitleTextStyle
        .copyWith(fontSize: 16),

    /// Default text
    bodyMedium: AppTheme._cupertinoLightTheme.textTheme.textStyle.copyWith(
      fontSize: 14,
      height: 1.3,
    ),
    labelSmall: AppTheme._cupertinoLightTheme.textTheme.textStyle.copyWith(
      color: CupertinoColors.secondaryLabel,
      fontSize: 11,
    ),
  );

  static TextTheme materialTextTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Colors.black,
      fontFamily: 'Linux Libertine',
      fontFamilyFallback: <String>[
        'Georgia',
        'Times',
        'Source Serif Pro',
        'serif',
      ],
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black, height: 1.3),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.labelOnLight,
    ),
  );
}

abstract final class AppDimensions {
  static const double radius = 8;
  static const double iconSize = 16;
}

abstract final class AppColors {
  static const Color primary = AppColors.flutterBlue5;
  static const Color labelOnLight = Color(0xFF4A4A4A);
  static const Color materialScaffoldBackgroundColor = Color(0xFFFFFFFF);
  static const Color cupertinoScaffoldBackgroundColor = Color(0xFFF1F1F1);

  /// All colors from Flutter's brand guidelines
  static const Color warmRed = Color.fromRGBO(242, 93, 80, 1);
  static const Color lightYellow = Color.fromRGBO(255, 242, 117, 1);

  static const Color flutterBlue5 = Color.fromRGBO(4, 104, 215, 1);
  static const Color flutterBlue4 = Color.fromRGBO(2, 125, 253, 1);
  static const Color flutterBlue3 = Color.fromRGBO(19, 185, 253, 1);
  static const Color flutterBlue2 = Color.fromRGBO(129, 221, 249, 1);
  static const Color flutterBlue1 = Color.fromRGBO(184, 224, 254, 1);
}
