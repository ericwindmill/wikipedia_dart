import 'package:args/args.dart';

ArgParser buildParser() {
  var parser = ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'interactive',
      abbr: 'i',
      negatable: false,
      help:
          'Start the interactive terminal app to fetch multiple items from Wikipedia.',
    )
    ..addOption(
      'type',
      abbr: 't',
      allowed: ['random', 'summary', 'timeline', 'article'],
      allowedHelp: {
        'random': 'Fetch a random article summary from wikipedia',
        'summary': 'Fetch an article summary from wikipedia by name',
        'timeline':
            'Get a list of events that happened on this day throughout history',
      },
    )
    ..addOption(
      'search',
      abbr: 's',
      valueHelp: 'TERM',
      help: 'Search any term on Wikipedia and get a list of urls in response',
    );

  return parser;
}

void printUsage(ArgParser argParser) {
  print('Usage: dart tool/wikipedia_cli.dart <flags> [arguments]');
  print(argParser.usage);
}
