import 'package:cli/src/outputs.dart';
import 'package:cli/src/utils/style_text.dart';
import 'package:cli/wikipedia_cli.dart';

void main(List<String> arguments) async {
  final InteractiveCommandRunner<String> app =
      InteractiveCommandRunner<String>()
        ..addCommand(TimelineCommand())
        ..addCommand(GetRandomArticle())
        ..addCommand(HelpCommand())
        ..addCommand(QuitCommand())
        ..listen(
          (String output) => console.write(output),
          onError: (Error error) {
            return console.write(error.toString().errorText);
          },
        );

  console.newScreen();
  await console.write('');
  if (console.windowWidth < Outputs.wikipediaTitle.split('\n').first.length) {
    await console.write(Outputs.narrowWindowTitle);
  } else {
    await console.write(Outputs.dartTitle);
    await console.write(Outputs.wikipediaTitle);
  }
  await console.write('');
  await Future<void>.delayed(const Duration(seconds: 1), () => '');
  console.newScreen();
  await app.run();
}
