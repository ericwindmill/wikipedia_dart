import 'ansi.dart';

extension Ansi on String {
  // Text color
  String get red => ConsoleColor.red.applyForeground(this);
  String get dartBlue => ConsoleColor.dart.applyForeground(this);

  // Text background colors
  String get dartBlueBackground => ConsoleColor.dart.applyBackground(this);

  // Styles
  String get bold => ConsoleTextStyle.bold.apply(this);
  String get italicize => ConsoleTextStyle.italic.apply(this);
  String get blinking => ConsoleTextStyle.blink.apply(this);

  String applyStyles(
    String text, {
    ConsoleColor? foreground,
    ConsoleColor? background,
    bool bold = false,
    bool faint = false,
    bool italic = false,
    bool underscore = false,
    bool blink = false,
    bool inverted = false,
    bool invisible = false,
    bool strikethru = false,
  }) {
    final styles = <int>[];
    if (foreground != null) {
      styles.addAll([38, 2, foreground.r, foreground.g, foreground.b]);
    }

    if (background != null) {
      styles.addAll([48, 2, background.r, background.g, background.b]);
    }

    if (bold) styles.add(1);
    if (faint) styles.add(2);
    if (italic) styles.add(3);
    if (underscore) styles.add(4);
    if (blink) styles.add(5);
    if (inverted) styles.add(7);
    if (invisible) styles.add(8);
    if (strikethru) styles.add(9);
    return '$ansiEscapeLiteral[${styles.join(";")}m$this$ansiEscapeLiteral[0m';
  }

  // // Foreground colors
  // String lightGray() => ansi.lightGray.wrap(this)!;
  // // String red() => ansi.red.wrap(this)!;
  // String black() => ansi.black.wrap(this)!;
  // String cyan() => ansi.cyan.wrap(this)!;
  // String blue() => ansi.blue.wrap(this, forScript: true)!;
  // String yellow() => ansi.yellow.wrap(this)!;
  //
  // // Background colors
  // String darkGrayBackground() => ansi.backgroundDarkGray.wrap(this)!;
  // String cyanBackground() => ansi.backgroundCyan.wrap(this)!;
  // String greenBackground() => ansi.backgroundGreen.wrap(this)!;
  // String yellowBackground() =>
  //     ansi.backgroundYellow.wrap(this, forScript: true)!;
  // String magentaBackground() => ansi.backgroundLightMagenta.wrap(this)!;
  //
  // String defaultTextStyle() =>
  //     ansi.wrapWith(this, [ansi.defaultForeground, ansi.backgroundDefault])!;
}
