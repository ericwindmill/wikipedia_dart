import 'dart:io';

import 'package:wikipedia_api/wikipedia_api.dart';

import '../../wikipedia_cli.dart';
import '../model/command.dart';
import '../outputs.dart';
import '../utils/style_text.dart';

class GetRandomArticle extends Command<String> {
  @override
  List<String> get aliases => <String>['r'];

  @override
  String get description =>
      'Print a random article summary from Wikipedia.';

  @override
  String get name => 'random';

  @override
  Stream<String> run({List<String>? args}) async* {
    try {
      final Summary summary =
          await WikipediaApiClient.getRandomArticle();

      console.newScreen();
      yield Outputs.summary(summary);
      yield ''; // new line
      yield Outputs.articleInstructions;
      final ConsoleControl key = await console.readKey();
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
      yield '\nUnknown error - $e\n'.red;
      yield s.toString();
    }
  }
}
