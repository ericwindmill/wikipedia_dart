import '../../wikipedia_cli.dart';
import '../model/command.dart';
import '../outputs.dart';

class HelpCommand extends Command<String> {
  @override
  String get name => 'help';

  @override
  String get description =>
      'Prints this usage information.';

  @override
  List<String> get aliases => <String>['h'];

  final List<String> _columns = <String>[
    'Command',
    'Description',
    'Args',
  ];

  @override
  Stream<String> run({List<String>? args}) async* {
    final Table table = Table(
      border: Border.fancy,
      headerColor: ConsoleColor.lightBlue,
    )..setHeaderRow(_columns);
    for (final Command<String> c in runner.commands) {
      table.insertRow(_valuesForCommand(c));
    }
    console
      ..resetCursorPosition()
      ..eraseDisplay();
    yield table.render();
    yield Outputs.enterACommand;
  }

  // Returns the pieces of usage, formatted
  // Pieces are [name(s), args, defaultArg, description].
  List<String> _valuesForCommand(Command<String> c) {
    final String name = <String>[
      c.name,
      ...c.aliases,
    ].join(', ');
    final List<String> values = <String>[
      name,
      c.description,
    ];
    if (c is Args) {
      final String defaultVal =
          c.argDefault != null
              ? ' default:${c.argDefault}'
              : '';
      final String required =
          c.argRequired ? 'required' : '';
      values.add(
        '${c.argName}=${c.argHelp} $required $defaultVal',
      );
    } else {
      values.add('');
    }
    return values;
  }
}
