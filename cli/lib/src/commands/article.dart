import 'dart:io';

import 'package:cli/src/utils/style_text.dart';
import 'package:shared/wikipedia_api.dart';

import '../../wikipedia_cli.dart';
import '../model/command.dart';
import '../outputs.dart';

class GetRandomArticle extends Command<String> {
  @override
  List<String> get aliases => ['r'];

  @override
  String get description => 'Print a random article summary from Wikipedia.';

  @override
  String get name => 'random';

  @override
  Stream<String> run({List<String>? args}) async* {
    try {
      Summary summary = await WikipediaApiClient.getRandomArticle();

      console.newScreen();
      yield Outputs.summary(summary);
      yield ''; // new line
      yield Outputs.articleInstructions;
      var key = await console.readKey();
      if (key == ConsoleControl.q) {
        console.newScreen();
        console.rawMode = false;
        runner.onInput('help');
      } else if (key == ConsoleControl.r) {
        runner.onInput('r');
      }
    } on HttpException catch (e) {
      yield Outputs.wikipediaHttpError(e);
    } catch (e, s) {
      yield ('\nUnknown error - $e\n'.red);
      yield (s.toString());
    }
  }
}
