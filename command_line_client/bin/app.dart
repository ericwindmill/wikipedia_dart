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

void handleNamedArticle(String name) async {
  print('Fetching $name article summary...');
  var summary = await WikipediaApiClient.getArticleSummary(name);
  Strings.prettyPrintSummary(summary);
}

void handleOnThisDayTimeline(String date) {}

class CommandLineApp {
  CommandLineApp() {
    print(Strings.titleScreen);
    print('');
    print(Strings.getStarted);
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
        case '2' || 'article':
          // _formatName();
          handleNamedArticle(args!);
        case '3' || 'on this day' || 'timeline':
          // verifyDate();
          handleOnThisDayTimeline(args!);
        case '4' || 'exit':
          _exit();
        default:
          print("Didn't recognize command $cmd. \n\n ${Strings.getStarted}");
      }

      print('Please enter another command. \n ${Strings.getStarted}');
    });
  }

  late StreamSubscription commandLineSubscription;

  void _exit() {
    commandLineSubscription.cancel();
    exit(0);
  }
}
