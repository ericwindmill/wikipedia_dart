import 'package:cli/src/outputs.dart';
import 'package:cli/wikipedia_cli.dart';
import 'package:test/test.dart';

void main() async {
  // This is not a thorough test
  test('HelpCommand.run', () async* {
    final HelpCommand help = HelpCommand();
    await for (final String str in help.run()) {
      expect(str, isNotNull, reason: "commands shouldn't yield null");
      emitsThrough(Outputs.enterACommand);
    }
  });
}
