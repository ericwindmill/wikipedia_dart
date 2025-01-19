const ansiEscapeLiteral = '\x1B';

enum ConsoleColor {
  red(200, 0, 0),
  dart(4, 56, 117);

  final int r;
  final int g;
  final int b;

  const ConsoleColor(this.r, this.b, this.g);

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
