library;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'command/command.dart';
import 'outputs.dart';
import 'utils/print.dart';

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

  late StreamSubscription _commandLineSubscription;
  final Map<String, Command> _commands = {};
  UnmodifiableSetView<Command> get commands =>
      UnmodifiableSetView({..._commands.values});

  void run() async {
    _commandLineSubscription = stdin.listen((data) async {
      var input = utf8.decode(data).trim();
      await onInput(input);
    });
    await write(Outputs.dartTitle);
    await write(Outputs.wikipediaTitle);
    // print usage to start
    onInput('help');
  }

  Future<void> onInput(String input) async {
    var allArgs = input.split(' ');
    var cmd = parse(allArgs.first);
    await for (final message in cmd.run(args: allArgs.sublist(1))) {
      await write(message);
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
    _commandLineSubscription.cancel();
    exit(code);
  }
}

// '\x1b[31m'
