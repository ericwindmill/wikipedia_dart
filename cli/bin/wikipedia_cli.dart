import 'package:cli/src/command/command.dart';
import 'package:cli/src/outputs.dart';
import 'package:cli/wikipedia_cli.dart';

void main(List<String> arguments) async {
  var app =
      InteractiveCommandRunner<String>()
        ..addCommand(TimelineCommand())
        ..addCommand(GetArticleCommand());

  await console.write('');
  await console.write(Outputs.dartTitle);
  await console.write(Outputs.wikipediaTitle);
  await console.write('');
  await Future.delayed(Duration(seconds: 1), () => '');
  console.eraseDisplay();
  console.resetCursorPosition();
  app.run();
}
