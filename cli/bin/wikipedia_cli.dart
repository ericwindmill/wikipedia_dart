import 'package:cli/src/outputs.dart';
import 'package:cli/wikipedia_cli.dart';

void main(List<String> arguments) async {
  final InteractiveCommandRunner<String> app =
      InteractiveCommandRunner<String>()
        ..addCommand(TimelineCommand())
        ..addCommand(GetRandomArticle())
        ..addCommand(HelpCommand())
        ..addCommand(QuitCommand());

  console.newScreen();
  await console.write('');
  await console.write(Outputs.dartTitle);
  await console.write(Outputs.wikipediaTitle);
  await console.write('');
  await Future<void>.delayed(const Duration(seconds: 1), () => '');
  console.newScreen();
  await app.run();
}
