library;

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:cli/src/utils/style_text.dart';

import 'model/command.dart';
import 'outputs.dart';
import 'console/console.dart';

/// [InteractiveCommandRunner] establishes a protocol for the
/// app to communicate with a continuously with an I/O source.
/// [T] represents the output of [InteractiveCommandRunner] (via [listen]),
/// and enforces proper return type of [Command.run]
///
/// ```dart
/// main() {
///   var app = InteractiveCommandRunner<String>()
///     ..addCommand(MyCommand())
///     ..addCommand(AnotherCommand());
///   app.run();
/// }
/// ```
///
/// When [run] is called, the app will start waiting for input from stdin.
/// On new input from stdin, the input will be parsed into a [Command],
/// and [Command.run] will be called.
/// The return value of [Command.run] is written to stdout.
///
/// Input can also be added via the [onInput] method.
class InteractiveCommandRunner<T> {
  final Map<String, Command> _commands = {};
  UnmodifiableSetView<Command> get commands =>
      UnmodifiableSetView({..._commands.values});

  void run() async {
    onInput('help');
    await for (var data in stdin) {
      // When control is released back to main input,
      // toggle rawMode off
      console.rawMode = false;
      var input = String.fromCharCodes(data).trim();
      await onInput(input);
    }
  }

  Future<void> onInput(String input) async {
    try {
      var allArgs = input.split(' ');
      var cmd = parse(allArgs.first);
      await for (final message in cmd.run(args: allArgs.sublist(1))) {
        await console.write(message.toString());
      }
    } catch (e) {
      console.write(e.toString().errorText);
    }
  }

  void addCommand(Command command) {
    for (var name in [command.name, ...command.aliases]) {
      if (_commands.containsKey(name)) {
        throw Exception(Outputs.inputExists(name));
      } else {
        _commands[name] = command;
        command.runner = this;
      }
    }
  }

  Command parse(String input) {
    if (_commands.containsKey(input)) {
      return _commands[input]!;
    }

    throw ArgumentError('Invalid input.');
  }

  void quit([int code = 0]) => _quit(code);

  void _quit(int code) {
    // Cancel subscriptions and close streams here
    exit(code);
  }
}
