part of 'command.dart';

class QuitCommand extends Command<String> {
  @override
  String get name => 'quit';

  @override
  List<String> get aliases => ['q', 'exit'];

  @override
  String get description => 'Exits the program.';

  @override
  Stream<String> run({List<String>? args}) async* {
    runner.quit();
    return;
  }
}
