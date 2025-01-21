import 'package:cli/src/command/command.dart';
import 'package:cli/src/console/console.dart';
import 'package:shared/wikipedia_api.dart';

import 'style_text.dart';

class Outputs {
  static String inputExists(String name) =>
      'Input $name already exists.'.errorText;

  static final dartTitle =
      '''
            ██████╗  █████╗ ██████╗ ████████╗              
            ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝              
            ██║  ██║███████║██████╔╝   ██║                 
            ██║  ██║██╔══██║██╔══██╗   ██║                 
            ██████╔╝██║  ██║██║  ██║   ██║                 
            ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝'''.displayTextLight;
  static final wikipediaTitle =
      '''            
██╗    ██╗██╗██╗  ██╗██╗██████╗ ███████╗██████╗ ██╗ █████╗ 
██║    ██║██║██║ ██╔╝██║██╔══██╗██╔════╝██╔══██╗██║██╔══██╗
██║ █╗ ██║██║█████╔╝ ██║██████╔╝█████╗  ██║  ██║██║███████║
██║███╗██║██║██╔═██╗ ██║██╔═══╝ ██╔══╝  ██║  ██║██║██╔══██║
╚███╔███╔╝██║██║  ██╗██║██║     ███████╗██████╔╝██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝
 '''.white;

  static String enterACommand =
      'Enter a command to continue.'.instructionTextLight;

  static String invalidArgs(Args arg) {
    var base = 'Invalid args for command.'.errorText;
    base += '\nUsage:\n${arg.usage}';
    return base;
  }

  static String onFirstEvent = "On first event, can't go back".errorText;
  static String endOfList = 'End of event list.';
  static String enterLeftOrRight =
      ' <- or -> to navigate, q to quit'.instructionTextLight;
  static String unknownInput = 'Unknown input.'.errorText;

  static String event(OnThisDayEvent event) {
    var strBuffer = StringBuffer('\n');
    strBuffer.write(" * ".lightBlue.bold);
    if (event.year != null) {
      strBuffer.write(event.year.toString().lightBlue.bold);
    } else {
      strBuffer.write('Holiday'.lightBlue.bold);
    }
    strBuffer.write('\n\n');
    var text = event.text.splitLinesByLength(50);
    for (var line in text) {
      strBuffer.write('   $line\n');
    }
    return strBuffer.toString();
  }
}
