import 'dart:io';
import 'dart:math' as math;

part 'ansi.dart';
part 'table.dart';

const ansiEscapeLiteral = '\x1B';

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
    if (hasTerminal) {
      stdin.lineMode = !value;
      stdin.echoMode = !value;
      _rawMode = value;
    }
  }

  /// Splits strings on `\n` characters, then writes each line to the
  /// console. [duration] defines how many milliseconds there will be
  /// between each line print.
  Future<void> write(String text, {int duration = 50}) async {
    var lines = text.split('\n');
    for (var l in lines) {
      await _delayedPrint('$l \n', duration: duration);
    }
  }

  /// Prints [input] to the console, then awaits for a response from [stdin].
  Future<String?> prompt(String input) async {
    await _delayedPrint(input);
    return stdin.readLineSync();
  }

  Future<void> _delayedPrint(String text, {int duration = 0}) async {
    return await Future.delayed(
      Duration(milliseconds: duration),
      () => stdout.write(text),
    );
  }

  void resetCursorPosition() =>
      stdout.write(ConsoleControl.resetCursorPosition.execute);

  void eraseLine() => stdout.write(ConsoleControl.eraseLine.execute);

  void eraseDisplay() => stdout.write(ConsoleControl.eraseDisplay.execute);

  /// Returns the width of the current console window in characters.
  int get windowWidth {
    if (hasTerminal) {
      return stdout.terminalColumns - 1;
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
