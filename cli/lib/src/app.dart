library;

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'command/command.dart';
import 'outputs.dart';
import 'console/io_utils.dart';

/// TODO: rewrite this
/// TODO: add dartdoc everywhere
/// [InteractiveCommandRunner] establishes a protocol for the
/// app to communicate with a continuously with an I/O source.
/// [T] represents the output of [InteractiveCommandRunner] (via [listen]),
/// and enforces proper return type of [Command.run]
///
/// ```dart
/// main() {
///  var runner = MyCommandRunner(stdin.listen((data) {
///       var input = utf8.decode(data).trim().toLowerCase();
///       onInput(input);
///    }));
///
///
///  runner.listen((output) {
///     print(output);
///  });
///
/// }
/// ```
///
/// Public API:
/// * [onInput] handles input from stdin.
/// * [output]
///
/// Implementing classes should override at least:
/// * [onInput], which is the entrypoint for stdin.
///
///
class InteractiveCommandRunner<T> {
  InteractiveCommandRunner() {
    addCommand(TimelineCommand());
    addCommand(HelpCommand());
    addCommand(QuitCommand());
  }

  final Map<String, Command> _commands = {};
  UnmodifiableSetView<Command> get commands =>
      UnmodifiableSetView({..._commands.values});

  void run() async {
    await write(Outputs.dartTitle);
    await write(Outputs.wikipediaTitle);
    // print usage to start
    onInput('help');
    await for (var data in stdin) {
      var input = String.fromCharCodes(data).trim();
      await onInput(input);
    }
  }

  Future<void> onInput(String input) async {
    try {
      var allArgs = input.split(' ');
      var cmd = parse(allArgs.first);
      await for (final message in cmd.run(args: allArgs.sublist(1))) {
        await write(message);
      }
    } catch (e) {
      // TODO: handle inputs
      write(e.toString());
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
