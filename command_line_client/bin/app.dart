import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'strings.dart';
import 'utils.dart';

import 'package:wikipedia_api/wikipedia_api.dart';

Future<void> handleRandomArticle() async {
  await delayedPrint('Fetching random article summary...');
  var summary = await WikipediaApiClient.getRandomArticle();
  prettyPrintSummary(summary);
}

Future<void> handleArticleSummary(String name) async {
  await delayedPrint('Fetching $name article summary...');
  var summary = await WikipediaApiClient.getArticleSummary(name);
  prettyPrintSummary(summary);
}

Future<void> handleOnThisDayTimeline(String date) async {
  var [String strMonth, String strDay] = date.split('/');
  var month = int.tryParse(strMonth);
  var day = int.tryParse(strDay);

  if (month == null || day == null) {
    print('Invalid date input: $month/$day');
  }

  var timeline = await WikipediaApiClient.getTimelineForDate(
    month: month!,
    day: day!,
  );
  for (var event in timeline.selected) {
    print("${event.year} = ${event.text}");
    print(event.pages.first.url);
    print('');
    print('Enter "N" for next event or "exit" to return to menu.');
    var input = stdin.readLineSync();
    var cmd = input != null ? input.trim().toLowerCase() : 'error';
    if (cmd == 'n') {
      continue;
    }
    if (cmd == 'exit') {
      break;
    }
    if (cmd == 'error') {
      print('Unrecognized command, exiting timeline reader');
      await delayedPrint(Strings.commands);
      break;
    }
  }
}

Future<void> handleArticle(String name) async {
  await delayedPrint('Fetching $name full article text');
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
  late StreamSubscription commandLineSubscription;

  void start() async {
    await printByLine(Strings.titleScreen.split('\n'));
    print('');
    await delayedPrint(Strings.getStarted);
    await delayedPrint(Strings.commands);

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
            await delayedPrint(Strings.missingArgument);
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
        default:
          print("Didn't recognize command $cmd. \n\n ${Strings.getStarted}");
      }
    });
  }

  void _printNext() async {
    print('');
    print(
      'Enter another command when ready, or type "help" to see the list of commands again',
    );
    await delayedPrint(Strings.commands);
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
