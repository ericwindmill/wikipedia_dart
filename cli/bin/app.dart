import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared/wikipedia_api.dart';

import 'strings.dart';
import 'print_utils.dart';
import 'utils.dart';


const normalLineLength = 60;

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
  stdin.echoMode = false;
  for (var event in timeline.selected) {
    await prettyPrintOnThisDayEvent(event);
    print('');
    stdout.write('-> or exit'.cyanBackground());
    var input = stdin.readLineSync();
    var cmd = input != null ? input.trim().toLowerCase() : 'error';
    if (cmd == 'n') {
      stdout.write('\r                                       ');
      stdout.write('\n');
      continue;
    }
    if (cmd == 'exit') {
      stdin.echoMode = true;
      break;
    }
    if (cmd == 'error') {
      print('Unrecognized command, exiting timeline reader'.red());
      await delayedPrint(Strings.commands);
      break;
    }
  }
}

Future<void> handleArticle(String name) async {
  await delayedPrint('Fetching $name full article text');
  try {
    var article = await WikimediaApiClient.getArticleByTitle(name);
    var lines = article.first.extract.split('\n');
    var i = 0;
    while (i < lines.length) {
      printByLine(lines.sublist(i, i + 10));
      stdout.write('n -> or exit'.cyanBackground().black());
      var input = stdin.readLineSync();
      var cmd = input != null ? input.trim().toLowerCase() : 'error';
      if (cmd == 'n') {
        i += 10;
        continue;
      }
      if (cmd == 'exit') {
        stdin.echoMode = true;
        break;
      }
      if (cmd == 'error') {
        print('Unrecognized command, exiting timeline reader'.red());
        await delayedPrint(Strings.commands);
        break;
      }
    }
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
          // TODO:
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
