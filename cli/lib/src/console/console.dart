import 'dart:io';
import 'dart:math' as math;

part 'ansi.dart';
part 'table.dart';

/// [Console] is a singleton. This will always return the same instance.
Console get console {
  return Console();
}

/// Convenience class that represents the current console window.
///
/// Use the [Console] to get information about the current window and to read
/// and write to it.
///
/// This is a simplified version of the Console class from the
/// dart_console package. It includes only whats needed for this demo.
/// https://pub.dev/packages/dart_console
class Console {
  factory Console() {
    return _console;
  }

  Console._();

  static final Console _console = Console._();

  /// When true, the terminal reads every keystroke without waiting for
  /// for a 'return' keystroke. And, it doesn't echo keystrokes.
  /// Useful for games and other interactive terminal experiences.
  bool get rawMode => _rawMode;
  bool _rawMode = false;
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
  Future<void> write(
    String text, {
    int duration = 50,
  }) async {
    final List<String> lines = text.split('\n');
    for (final String l in lines) {
      await _delayedPrint('$l \n', duration: duration);
    }
  }

  /// Prints [input] to the console, then awaits for a response from [stdin].
  Future<String?> prompt(String input) async {
    await _delayedPrint(input);
    return stdin.readLineSync();
  }

  /// Set cursor to top-left corner
  void resetCursorPosition() => stdout.write(
    ConsoleControl.resetCursorPosition.execute,
  );

  void eraseLine() =>
      stdout.write(ConsoleControl.eraseLine.execute);

  void eraseDisplay() =>
      stdout.write(ConsoleControl.eraseDisplay.execute);

  /// Resets the console screen and positions the cursor in the top-left corner.
  void newScreen() {
    eraseDisplay();
    resetCursorPosition();
  }

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
  /// Most likely 'false' in CI environments.
  bool get hasTerminal => stdout.hasTerminal;

  /// Reads a keystroke as a series of bytes, outputs which key
  /// was entered (as a [ConsoleControl]).
  ///
  /// As this is a demo, only the keys this program cares about are handled.
  /// If you want to handle more key inputs, add keys to the [ConsoleControl]
  /// enum, and then handle parsing them here.
  Future<ConsoleControl> readKey() async {
    rawMode = true;
    int codeUnit = 0;
    ConsoleControl key = ConsoleControl.unknown;

    // Get first code unit
    // Afterwords, stdin IOSink potentially
    // has more bytes waiting to be read.
    while (codeUnit <= 0) {
      codeUnit = stdin.readByteSync();
      break;
    }

    // handle A-Za-z
    if (codeUnit >= 65 && codeUnit < 91 ||
        codeUnit >= 97 ||
        codeUnit < 123) {
      // We only care about 'q' and 'Q'
      if (codeUnit == 113 || codeUnit == 81) {
        return ConsoleControl.q;
      }
      if (codeUnit == 114 || codeUnit == 82) {
        return ConsoleControl.r;
      }
    }

    // handle escape
    if (codeUnit == 0x1b) {
      codeUnit = stdin.readByteSync();
      String nextChar = String.fromCharCode(codeUnit);
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

  Future<void> _delayedPrint(
    String text, {
    int duration = 0,
  }) async {
    return Future.delayed(
      Duration(milliseconds: duration),
      () => stdout.write(text),
    );
  }
}
