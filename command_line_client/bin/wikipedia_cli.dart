import 'dart:io';

import 'package:args/args.dart';

import 'parser.dart';
import 'app.dart';

void main(List<String> arguments) async {
  final ArgParser argParser = buildParser();

  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }

    if (results.option('type') == 'random') {
      handleRandomArticle();
    }

    if (results.option('type') == 'summary') {
      // ask user for article name
      print('What article would you like to fetch? [name]');
      String? name = stdin.readLineSync();
      if (name == null) {
        print("No name provided, fetching article for 'cat'");
        name = 'cat';
      }
      handleArticleSummary(name);
    }

    if (results.option('type') == 'timeline') {
      print('Please enter a date in this format: MM/DD, padded with zeroes.');
      String? date = stdin.readLineSync();
      if (date == null) {
        print("No date provided, using January 1");
        date = "01/01";
      }
      handleOnThisDayTimeline(date);
    }

    if (results.option('type') == 'article') {
      print('What article would you like to fetch? [name]');
      String? name = stdin.readLineSync();
      if (name == null) {
        print("No name provided, fetching article for 'cat'");
        name = 'cat';
      }
      handleArticle(name);
    }

    if (results.option('search') != null) {
      handleSearch(results.option('search')!);
    }

    if (results.flag('interactive')) {
      // Launch the interactive CLI
      final app = CommandLineApp();
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
