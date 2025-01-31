import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/page_link_extension.dart';

/// I copied this from the compass_app. IRL the AppTheme will be much smaller.
abstract final class AppTheme {
  // Map cupertino styles to MaterialTheme naming convention
  static TextTheme cupertinoTextTheme = TextTheme(
    headlineMedium: const CupertinoThemeData().textTheme.navLargeTitleTextStyle
    // fixes a small bug with spacing
    .copyWith(letterSpacing: -1.5),
    titleLarge: const CupertinoThemeData().textTheme.navTitleTextStyle,
  );

  static const TextStyle serif = TextStyle(
    fontFamily: 'Linux Libertine',
    fontFamilyFallback: <String>[
      'Georgia',
      'Times',
      'Source Serif Pro',
      'serif',
    ],
    fontWeight: FontWeight.w500,
  );

  static const TextStyle timelineEntryTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static const TextTheme _textTheme = TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontWeight: FontWeight.bold),

    /// Default text
    bodyMedium: TextStyle(fontWeight: FontWeight.w400),

    /// Used for labels and captions
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.labelOnLight,
    ),
  );

  static CupertinoThemeData cupertinoLightTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  );

  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: Colors.white,
    onPrimaryContainer: AppColors.labelOnLight,
    shadow: Colors.black12,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: _textTheme,
    brightness: Brightness.light,
    colorScheme: AppTheme.lightColorScheme,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    extensions: <ThemeExtension<PageLinkTheme>>[
      PageLinkTheme(backgroundColor: Colors.grey.shade200),
    ],
  );
}

abstract final class AppColors {
  static const Color primary = AppColors.flutterBlue5;
  static const Color containerOnDark = Color(0xFF131313);
  static const Color labelOnLight = Color(0xFF4A4A4A);
  static const Color labelOnDark = Color(0xFFDADCE0);
  static const Color scaffoldBackgroundColor = Color(0xFFF1F1F1);

  /// All colors from Flutter's brand guidelines
  static const Color warmRed = Color.fromRGBO(242, 93, 80, 1);
  static const Color lightYellow = Color.fromRGBO(255, 242, 117, 1);
  static const Color violet = Color.fromRGBO(98, 0, 238, 1);
  static const Color teal = Color.fromRGBO(18, 129, 117, 1.0);

  static const Color flutterBlue6 = Color.fromRGBO(5, 83, 177, 1);
  static const Color flutterBlue5 = Color.fromRGBO(4, 104, 215, 1);
  static const Color flutterBlue4 = Color.fromRGBO(2, 125, 253, 1);
  static const Color flutterBlue3 = Color.fromRGBO(19, 185, 253, 1);
  static const Color flutterBlue2 = Color.fromRGBO(129, 221, 249, 1);
  static const Color flutterBlue1 = Color.fromRGBO(184, 224, 254, 1);

  static const List<Color> blues = [
    AppColors.flutterBlue1,
    AppColors.flutterBlue2,
    AppColors.flutterBlue3,
    AppColors.flutterBlue4,
    AppColors.flutterBlue5,
    AppColors.flutterBlue6,
  ];
}
