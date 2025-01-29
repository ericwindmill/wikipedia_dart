import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/page_link_extension.dart';

/// I copied this from the compass_app. IRL the AppTheme will be much smaller.
abstract final class AppTheme {
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

  static const TextTheme _textThemeDark = TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

    /// Default text
    bodyMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),

    /// Used for labels and captions
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.labelOnDark,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: _textTheme,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    extensions: <ThemeExtension<PageLinkTheme>>[
      PageLinkTheme(backgroundColor: Colors.grey.shade200),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    textTheme: _textThemeDark,
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    scaffoldBackgroundColor: Colors.black,
    shadowColor: Colors.black12,
    extensions: <ThemeExtension<PageLinkTheme>>[
      PageLinkTheme(backgroundColor: Colors.grey.shade800),
    ],
  );
}

abstract final class AppColors {
  static const Color primary = AppColors.flutterBlue5;
  static const Color containerOnDark = Color(0xFF181818);
  static const Color labelOnLight = Color(0xFF4A4A4A);
  static const Color labelOnDark = Color(0xFFDADCE0);

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

  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: Colors.white,
    shadow: Colors.black12,
  );

  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    primaryContainer: AppColors.containerOnDark,
    surface: Colors.black,
  );
}
