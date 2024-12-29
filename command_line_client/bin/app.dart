import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'strings.dart';

import 'package:wikipedia_api/wikipedia_api.dart';

Future<void> handleRandomArticle() async {
  print('Fetching random article summary...');
  var summary = await WikipediaApiClient.getRandomArticle();
  Strings.prettyPrintSummary(summary);
}

Future<void> handleArticleSummary(String name) async {
  print('Fetching $name article summary...');
  var summary = await WikipediaApiClient.getArticleSummary(name);
  Strings.prettyPrintSummary(summary);
}

Future<void> handleOnThisDayTimeline(String date) {
  throw 'TODO';
}

Future<void> handleArticle(String name) async {
  print('Fetching $name full article text');
  try {
    var article = await WikimediaApiClient.getArticleByTitle(name);
    print(article);
  } catch (e) {
    print(e);
  }
}

Future<void> handleSearch(String term) async {
  print('Searching wikipedia for $term...');
  try {
    var searchResults = await WikimediaApiClient.search(term);
    print(searchResults.toString());
  } catch (e) {
    print(e);
  }
}

class CommandLineApp {
  CommandLineApp() {
    print(Strings.titleScreen);
    print('');
    print(Strings.getStarted);
    print(Strings.commands);
    commandLineSubscription = stdin.listen((input) async {
      var cmdReadable = utf8.decode(input);
      String cmd;
      String? args;
      if (cmdReadable.contains("=")) {
        [cmd, args] = cmdReadable.split("=");
      } else {
        cmd = cmdReadable.trim().toLowerCase();
      }

      switch (cmd) {
        case '1' || 'random' || 'random article':
          await handleRandomArticle();
          _printNext();
        case '2' || 'article' || 'full article':
          if (_verifyArgumentExists(cmd, args)) {
            // _formatName();
            await handleArticle(args!);
            _printNext();
          } else {
            print(Strings.missingArgument);
          }
        case '3' || 'summary' || 'article summary':
          await handleArticleSummary(args!);
          _printNext();
        case '4' || 'on this day' || 'timeline':
          // verifyDate();
          await handleOnThisDayTimeline(args!);
          _printNext();
        case '5' || 'search':
          await handleSearch(args!);
          _printNext();
        case '6' || 'help':
          _printUsage();
        case '7' || 'exit':
          _exit();
          _printNext();
        default:
          print("Didn't recognize command $cmd. \n\n ${Strings.getStarted}");
      }
    });
  }

  late StreamSubscription commandLineSubscription;

  void _printNext() {
    print('');
    print(
        'Enter another command when ready, or type "help" to see the list of commands again');
    print('');
  }

  void _printUsage() {
    print(Strings.getStarted);
    print(Strings.commands);
  }

  bool _verifyArgumentExists(String cmd, String? args) {
    if (args == null || args.isEmpty) return false;
    return true;
  }

  void _exit() {
    commandLineSubscription.cancel();
    exit(0);
  }
}
