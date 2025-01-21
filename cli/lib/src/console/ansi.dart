part of 'console.dart';

/// Reads the incoming bytes from stdin, and determines which
/// [ConsoleControl] key has been entered.
///
/// As a demo, this only handles the keys this program cares about.
/// If you want to handle more key inputs, add keys to the [ConsoleControl]
/// enum, and then handle parsing them here.
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
  unknown('');

  final String ansiCode;
  const ConsoleControl(this.ansiCode);

  String get execute => '$ansiEscapeLiteral[$ansiCode';
}

// As a demo, only includes colors this program cares about.
// If you want to use more colors, add them here.
/// All colors from Dart's brand styleguide
enum ConsoleColor {
  dartPrimaryDark(4, 56, 117),
  dartPrimaryLight(184, 234, 254),
  red(242, 93, 80),
  white(255, 255, 255),
  teal(28, 218, 197),
  yellow(255, 242, 117);

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

extension Ansi on String {
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
        strBuffer.write(word);
        if (strBuffer.length + 1 <= length) {
          strBuffer.write(' ');
        }
      }
      // If the next word surpasses length, start the next line
      if (i + 1 < words.length &&
          words[i + 1].length + strBuffer.length + 1 > length) {
        output.add(strBuffer.toString());
        strBuffer.clear();
      }
    }

    // Add left overs
    output.add(strBuffer.toString());
    return output;
  }
}
