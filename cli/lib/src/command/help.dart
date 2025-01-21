part of 'command.dart';

class HelpCommand extends Command<String> {
  @override
  String get name => 'help';

  @override
  String get description => 'Prints this usage information.';

  @override
  List<String> get aliases => ['h'];

  final List<String> _columns = ['Command', 'Args', 'Descriptions'];

  @override
  Stream<String> run({List<String>? args}) async* {
    var table = Table(
      title: Outputs.enterACommand,
      border: Border.ascii,
      titleColor: ConsoleColor.dartPrimaryLight,
    )..setHeaderRow(_columns);
    for (var c in runner.commands) {
      table.insertRow(_valuesForCommand(c));
    }
    yield table.render();
  }

  // Returns the pieces of usage, formatted
  // Pieces are [name(s), args, defaultArg, description].
  List<String> _valuesForCommand(Command c) {
    var name = [c.name, ...c.aliases].join(', ');
    var values = [name];
    if (c is Args) {
      var defaultVal = c.argDefault != null ? ' default:${c.argDefault}' : '';
      var required = c.required ? 'required' : '';
      values.add('${c.argName}=${c.argHelp} $required $defaultVal');
    } else {
      values.add('');
    }
    values.add(c.description);
    return values;
  }
}
