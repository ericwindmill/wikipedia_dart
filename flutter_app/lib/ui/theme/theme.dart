import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/page_link_extension.dart';

/// I copied this from the compass_app. IRL the AppTheme will be much smaller.
abstract final class AppTheme {
  static const TextStyle serifTitle = TextStyle(
    fontFamily: 'Linux Libertine',
    fontFamilyFallback: <String>[
      'Georgia',
      'Times',
      'Source Serif Pro',
      'serif',
    ],
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle timelineEntryTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static const TextTheme _textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

    /// Default text
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),

    /// Used for labels and captions
    labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.labelLight,
    ),
  );

  static const TextTheme _textThemeDark = TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

    /// Default text
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),

    /// Used for labels and captions
    labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.labelDark,
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
  static const Color primary = Color.fromRGBO(4, 104, 215, 1);
  static const Color containerOnDark = Color(0xFF181818);
  static const Color labelLight = Color(0xFF1E1E1E);
  static const Color labelDark = Color(0xFFC4C0C0);

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
