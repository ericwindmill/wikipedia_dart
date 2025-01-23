import 'package:cli/wikipedia_cli.dart';
import 'package:test/test.dart';

main() async {
  var app = InteractiveCommandRunner<String>();

  test('', () async {
    var help = app.commands.firstWhere((c) => c is HelpCommand);
    await for (var str in help.run()) {
      print(str);
    }
  });
}
