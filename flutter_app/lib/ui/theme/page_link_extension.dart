import 'package:flutter/material.dart';

class PageLinkTheme extends ThemeExtension<PageLinkTheme> {
  PageLinkTheme({required this.backgroundColor});
  final Color backgroundColor;

  @override
  ThemeExtension<PageLinkTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
  }) {
    return PageLinkTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<PageLinkTheme> lerp(
    covariant ThemeExtension<PageLinkTheme> other,
    double t,
  ) {
    if (other is! PageLinkTheme) {
      return this;
    }
    return PageLinkTheme(
      backgroundColor:
          Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
    );
  }
}
