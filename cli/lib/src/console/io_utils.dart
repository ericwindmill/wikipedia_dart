import 'dart:io';

import 'style_text.dart';

/// Prints [input] to the console, then awaits for a response from [stdin].
Future<String?> prompt(String input) async {
  await _delayedPrint(input);
  return stdin.readLineSync();
}

Future<void> _delayedPrint(String text, {int duration = 100}) async {
  return await Future.delayed(
    Duration(milliseconds: duration),
    () => print(text),
  );
}

/// Splits strings on `\n` characters, then writes each line to the
/// console. [duration] defines how many milliseconds there will be
/// between each line print.
Future<void> write(String text, {int duration = 100}) async {
  var lines = text.split('\n');
  for (var l in lines) {
    await _delayedPrint(l);
  }
}

void toggleRawMode() {
  stdin.lineMode = false;
  stdin.echoMode = false;
}

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

  static Future<ConsoleControl> readKey() async {
    toggleRawMode();
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
    toggleRawMode();
    return key;
  }
}
