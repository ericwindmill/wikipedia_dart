import 'package:wikipedia_api/wikipedia_api.dart';

class Strings {
  static final welcome = 'Welcome to Wikipedia Dart!';
  static final getStarted = 'To get started, tell me what you want to do:';
  static final commands = '''
1. Random - Get a random article summary from Wikipedia.
2. Article=<NAME> - Get an article summary from Wikipedia by name. (e.g. article=cat)
3. Timeline=MM/DD - Get a list of events that happened on this time through out history. (e.g. timeline=08/02) 
4. Exit - Quit the application.

To make a selection, enter the number [1-4], and add provide it's arguments if necessary.''';
  static final titleScreen = '''
            ██████╗  █████╗ ██████╗ ████████╗              
            ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝              
            ██║  ██║███████║██████╔╝   ██║                 
            ██║  ██║██╔══██║██╔══██╗   ██║                 
            ██████╔╝██║  ██║██║  ██║   ██║                 
            ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝                 
██╗    ██╗██╗██╗  ██╗██╗██████╗ ███████╗██████╗ ██╗ █████╗ 
██║    ██║██║██║ ██╔╝██║██╔══██╗██╔════╝██╔══██╗██║██╔══██╗
██║ █╗ ██║██║█████╔╝ ██║██████╔╝█████╗  ██║  ██║██║███████║
██║███╗██║██║██╔═██╗ ██║██╔═══╝ ██╔══╝  ██║  ██║██║██╔══██║
╚███╔███╔╝██║██║  ██╗██║██║     ███████╗██████╔╝██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝ 
 ''';

  static void prettyPrintSummary(Summary summary) {
    print('=== ${summary.titles.normalized} ===');
    print(summary.extract);
    print('Read more: ${summary.url}');
    print(' ');
  }
}
