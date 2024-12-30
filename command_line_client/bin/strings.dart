import 'package:wikipedia_api/wikipedia_api.dart';

class Strings {
  static final welcome = 'Welcome to Wikipedia Dart!';
  static final getStarted = 'To get started, tell me what you want to do:';
  static final commands = '''
1. Random - Get a random article summary from Wikipedia.
2. Article=<TITLE> - Get an article from Wikipedia by name. (e.g. article=cat)
3. Summary=<TITLE> - Get an article summary from Wikipedia by name. (e.g. summary=cat)
4. Timeline=<MM/DD> - Get a list of events that happened on this time through out history. (e.g. timeline=08/02)
5. Search=<TERM> - Search for Wikipedia articles related to a term. (e.g. search=dart)
6. Help - Get usage information about this app.
7. Exit - Quit the application.

To make a selection, enter the number [1-7], and add provide it's arguments if necessary.''';
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

  static final missingArgument =
      'That command requires an argument. Please try again with an argument in the following format: <CMD>=<ARG>. For example, you can get an article with 2=cat';
}
