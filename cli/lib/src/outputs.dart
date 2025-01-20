import 'package:cli/src/command/command.dart';
import 'package:shared/wikipedia_api.dart';

import './console/style_text.dart';

// TODO add the rest of the CLI strings, and stylize properly
// TODO move some strings to the shared lib
// TODO - use color scheme -- all reminder text one color, error text another, etc

class Outputs {
  static String inputExists(String name) => 'Input $name already exists.'.red;

  static final dartTitle =
      '''
            ██████╗  █████╗ ██████╗ ████████╗              
            ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝              
            ██║  ██║███████║██████╔╝   ██║                 
            ██║  ██║██╔══██║██╔══██╗   ██║                 
            ██████╔╝██║  ██║██║  ██║   ██║                 
            ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝                 
 '''.dartBlue;

  static final wikipediaTitle = '''            
██╗    ██╗██╗██╗  ██╗██╗██████╗ ███████╗██████╗ ██╗ █████╗ 
██║    ██║██║██║ ██╔╝██║██╔══██╗██╔════╝██╔══██╗██║██╔══██╗
██║ █╗ ██║██║█████╔╝ ██║██████╔╝█████╗  ██║  ██║██║███████║
██║███╗██║██║██╔═██╗ ██║██╔═══╝ ██╔══╝  ██║  ██║██║██╔══██║
╚███╔███╔╝██║██║  ██╗██║██║     ███████╗██████╔╝██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝ 
 ''';

  static String invalidArgs(Args arg) {
    var base = 'Invalid args for command.'.red;
    base += '\nUsage:\n${arg.usage}';
    return base;
  }

  static String onFirstEvent = "On first event, can't go back";
  static String endOfList = 'End of event list.';
  static String enterLeftOrRight = 'enter <- or ->';
  static String unknownInput = 'Unknown input.'.red;

  static String event(OnThisDayEvent event) {
    var strBuffer = StringBuffer(" * ".dartBlue.bold);
    if (event.year != null) {
      strBuffer.write(event.year.toString().dartBlue.bold);
    } else {
      strBuffer.write('Holiday'.dartBlue.bold);
    }
    strBuffer.write('\n');
    var text = event.text.splitLinesByLength(50);
    for (var line in text) {
      strBuffer.write('$line\n');
    }
    return strBuffer.toString();
  }
}
