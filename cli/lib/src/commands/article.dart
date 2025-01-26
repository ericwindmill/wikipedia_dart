import 'dart:io';

import 'package:cli/src/model/command.dart';
import 'package:cli/src/outputs.dart';
import 'package:cli/wikipedia_cli.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class GetRandomArticle extends Command<String> {
  @override
  List<String> get aliases => <String>['r'];

  @override
  String get description => 'Print a random article summary from Wikipedia.';

  @override
  String get name => 'random';

  @override
  Stream<String> run({List<String>? args}) async* {
    try {
      final Summary summary = await WikipediaApiClient.getRandomArticle();

      console.newScreen();
      yield Outputs.summary(summary);
      yield ''; // new line
      yield Outputs.articleInstructions;
      final ConsoleControl key = await console.readKey();
      if (key == ConsoleControl.q) {
        console
          ..newScreen()
          ..rawMode = false;
        await runner.onInput('help');
      } else if (key == ConsoleControl.r) {
        await runner.onInput('r');
      }
    } on HttpException catch (e) {
      yield Outputs.wikipediaHttpError(e);
    }
  }
}
