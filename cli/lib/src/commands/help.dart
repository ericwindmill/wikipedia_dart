import '../../wikipedia_cli.dart';
import '../model/command.dart';
import '../outputs.dart';

class HelpCommand extends Command<String> {
  @override
  String get name => 'help';

  @override
  String get description => 'Prints this usage information.';

  @override
  List<String> get aliases => ['h'];

  final List<String> _columns = ['Command', 'Description', 'Args'];

  @override
  Stream<String> run({List<String>? args}) async* {
    var table = Table(border: Border.fancy, headerColor: ConsoleColor.lightBlue)
      ..setHeaderRow(_columns);
    for (var c in runner.commands) {
      table.insertRow(_valuesForCommand(c));
    }
    console.resetCursorPosition();
    console.eraseDisplay();
    yield table.render();
    yield Outputs.enterACommand;
  }

  // Returns the pieces of usage, formatted
  // Pieces are [name(s), args, defaultArg, description].
  List<String> _valuesForCommand(Command c) {
    var name = [c.name, ...c.aliases].join(', ');
    var values = [name, c.description];
    if (c is Args) {
      var defaultVal = c.argDefault != null ? ' default:${c.argDefault}' : '';
      var required = c.argRequired ? 'required' : '';
      values.add('${c.argName}=${c.argHelp} $required $defaultVal');
    } else {
      values.add('');
    }
    return values;
  }
}
