import 'dart:io';

import 'style_text.dart';

const ansiEraseInLineAll = '\x1b[2K';

/// Reads the incoming bytes from stdin, and determines which
/// [ConsoleControl] key has been entered.
///
/// As a demo, this only handles the keys this program cares about.
/// If you want to handle more key inputs, add keys to the [ConsoleControl]
/// enum, and then handle parsing them here.
enum ConsoleControl {
  cursorLeft('D', 30),
  cursorRight('C', 29),
  cursorUp('A', 27),
  cursorDown('B', 28),
  b('b', 98),
  q('q', 113),
  unknown('', -1);

  final String ansiCode;
  final int codeUnit;
  const ConsoleControl(this.ansiCode, this.codeUnit);

  String get execute => '$ansiEscapeLiteral[$ansiCode';
}

/// [Console] is a singleton. This will always return the same instance.
Console get console {
  return Console();
}

/// Utility class that handles I/O
class Console {
  // This class is a singleton
  Console._();
  static final Console _console = Console._();
  factory Console() {
    return _console;
  }

  bool _rawMode = false;
  bool get rawMode => _rawMode;
  set rawMode(bool value) {
    stdin.lineMode = !value;
    stdin.echoMode = !value;
    _rawMode = value;
  }

  /// Splits strings on `\n` characters, then writes each line to the
  /// console. [duration] defines how many milliseconds there will be
  /// between each line print.
  Future<void> write(String text, {int duration = 100}) async {
    var lines = text.split('\n');
    for (var l in lines) {
      await _delayedPrint('$l \n');
    }
  }

  /// Prints [input] to the console, then awaits for a response from [stdin].
  Future<String?> prompt(String input) async {
    await _delayedPrint(input);
    return stdin.readLineSync();
  }

  Future<void> _delayedPrint(String text, {int duration = 100}) async {
    return await Future.delayed(
      Duration(milliseconds: duration),
      () => stdout.write(text),
    );
  }

  void eraseLine() => stdout.write(ansiEraseInLineAll);

  /// Returns the width of the current console window in characters.
  int get windowWidth {
    if (hasTerminal) {
      return stdout.terminalColumns;
    } else {
      // Treat a window that has no terminal as if it is 80x25. This should be
      // more compatible with CI/CD environments.
      return 80;
    }
  }

  /// Returns the height of the current console window in characters.
  int get windowHeight {
    if (hasTerminal) {
      return stdout.terminalLines;
    } else {
      // Treat a window that has no terminal as if it is 80x25. This should be
      // more compatible with CI/CD environments.
      return 25;
    }
  }

  /// Whether there is a terminal attached to stdout.
  bool get hasTerminal => stdout.hasTerminal;

  Future<ConsoleControl> readKey() async {
    rawMode = true;
    var codeUnit = 0;
    ConsoleControl key = ConsoleControl.unknown;

    // Get first code unit
    // Afterwords, stdin IOSink potentially
    // has more bytes waiting to be read.
    while (codeUnit <= 0) {
      codeUnit = stdin.readByteSync();
      break;
    }

    // handle A-Za-z
    if (codeUnit >= 65 && codeUnit < 91 || codeUnit >= 97 || codeUnit < 123) {
      // We only care about 'q' and 'Q'
      if (codeUnit == 113 || codeUnit == 81) {
        return ConsoleControl.q;
      }
    }

    // handle escape
    if (codeUnit == 0x1b) {
      codeUnit = stdin.readByteSync();
      var nextChar = String.fromCharCode(codeUnit);
      if (nextChar == '[') {
        codeUnit = stdin.readByteSync();
        nextChar = String.fromCharCode(codeUnit);
        key = switch (nextChar) {
          'A' => ConsoleControl.cursorUp,
          'B' => ConsoleControl.cursorDown,
          'C' => ConsoleControl.cursorRight,
          'D' => ConsoleControl.cursorUp,
          _ => ConsoleControl.unknown,
        };
      }
    }
    rawMode = false;
    return key;
  }
}
