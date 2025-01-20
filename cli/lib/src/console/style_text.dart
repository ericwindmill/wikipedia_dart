const ansiEscapeLiteral = '\x1B';

// As a demo, only includes colors this program cares about.
// If you want to use more colors, add them here.
enum ConsoleColor {
  red(200, 0, 0),
  white(0, 0, 0),
  dartPrimary(4, 56, 117),
  dartSecondary(0, 0, 0);

  final int r;
  final int g;
  final int b;

  const ConsoleColor(this.r, this.g, this.b);

  /// Change text color for all future output (until reset)
  /// ```dart
  /// print('hello'); // prints in terminal default color
  /// print('AnsiColor.red.enableForeground');
  /// print('hello'); // prints in red color
  /// ```
  String get enableForeground => '$ansiEscapeLiteral[38;2;$r;$g;${b}m';

  /// Change text color for all future output (until reset)
  /// ```dart
  /// print('hello'); // prints in terminal default color
  /// print('AnsiColor.red.enableForeground');
  /// print('hello'); // prints in red color
  /// ```
  String get enableBackground => '$ansiEscapeLiteral[48;2;$r;$g;${b}m';

  /// Reset text and background color to terminal defaults
  static String get reset => '$ansiEscapeLiteral[0m';

  /// Sets text color and then resets the color change
  String applyForeground(String text) {
    return '$ansiEscapeLiteral[38;2;$r;$g;${b}m$text$ansiEscapeLiteral[0m';
  }

  /// Sets background color and then resets the color change
  String applyBackground(String text) {
    return '$ansiEscapeLiteral[48;2;$r;$g;${b}m$text$ansiEscapeLiteral[0m';
  }
}

enum ConsoleTextStyle {
  bold(1),
  faint(2),
  italic(3),
  underscore(4),
  blink(5),
  inverted(6),
  invisible(7),
  strikethru(8);

  final int ansiCode;
  const ConsoleTextStyle(this.ansiCode);

  String apply(String text) {
    return '$ansiEscapeLiteral[$ansiCode;m$text';
  }
}

extension StyleText on String {
  // Text color
  String get red => ConsoleColor.red.applyForeground(this);
  String get dartBlue => ConsoleColor.dartPrimary.applyForeground(this);

  // Text background colors
  String get dartBlueBackground =>
      ConsoleColor.dartPrimary.applyBackground(this);

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

  // TODO - finish adding colors
  // Foreground colors
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
