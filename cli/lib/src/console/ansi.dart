part of 'console.dart';

/// Reads the incoming bytes from stdin, and determines which
/// [ConsoleControl] key has been entered.
///
/// As this is a demo, only the keys this program cares about are included.
/// If you want to handle more key inputs, add keys to this enum, then handle
/// them in [Console.readKey].
enum ConsoleControl {
  cursorLeft('D'),
  cursorRight('C'),
  cursorUp('A'),
  cursorDown('B'),
  // Sets the cursor to the top left corner of the window
  resetCursorPosition('H'),
  eraseLine('2K'),
  eraseDisplay('2J'),
  q('q'),
  r('r'),
  unknown('');

  final String ansiCode;
  const ConsoleControl(this.ansiCode);

  String get execute => '$ansiEscapeLiteral[$ansiCode';
}

// As a demo, only includes colors this program cares about.
// If you want to use more colors, add them here.
/// All colors from Dart's brand styleguide
enum ConsoleColor {
  /// Navy blue - #043875
  dartBlue(4, 56, 117),

  ///True blue - #027dfd2
  flutterBlue(2, 125, 253),

  /// Sky blue - #b8eafe
  lightBlue(184, 234, 254),

  /// Accent colors from Dart's brand guidelines
  /// Warm red - #F25D50
  red(242, 93, 80),

  /// #1CDAC5
  teal(28, 218, 197),

  /// Light yellow - #F9F8C4
  yellow(249, 248, 196),

  /// Light grey, good for text, #F8F9FA
  grey(240, 240, 240),
  white(255, 255, 255);

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
    return '$ansiEscapeLiteral[38;2;$r;$g;${b}m$text';
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

extension AnsiUtils on String {
  String applyStyles({
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

  String get strip {
    return replaceAll(RegExp(r'\x1b\[[\x30-\x3f]*[\x20-\x2f]*[\x40-\x7e]'), '')
        .replaceAll(RegExp(r'\x1b[PX^_].*?\x1b\\'), '')
        .replaceAll(RegExp(r'\x1b\][^\a]*(?:\a|\x1b\\)'), '')
        .replaceAll(RegExp(r'\x1b[\[\]A-Z\\^_@]'), '');
  }

  List<String> splitLinesByLength(int length) {
    var words = split(' ');
    var output = <String>[];
    var strBuffer = StringBuffer();
    for (var i = 0; i < words.length; i++) {
      var word = words[i];
      if (strBuffer.length + word.length <= length) {
        strBuffer.write(word.trim());
        if (strBuffer.length + 1 <= length) {
          strBuffer.write(' ');
        }
      }
      // If the next word surpasses length, start the next line
      if (i + 1 < words.length &&
          words[i + 1].length + strBuffer.length + 1 > length) {
        output.add(strBuffer.toString().trim());
        strBuffer.clear();
      }
    }

    // Add left overs
    output.add(strBuffer.toString().trim());
    return output;
  }
}
