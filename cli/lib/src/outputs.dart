import 'dart:io';

import 'package:cli/src/console/console.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import 'model/command.dart';
import 'utils/style_text.dart';

class Outputs {
  // DO NOT EDIT THIS -- whitespaces can break the rendering when centered
  static final dartTitle =
      '''
██████╗  █████╗ ██████╗ ████████╗
██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
██║  ██║███████║██████╔╝   ██║   
██║  ██║██╔══██║██╔══██╗   ██║   
██████╔╝██║  ██║██║  ██║   ██║   
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   '''.center.displayText;
  static final wikipediaTitle =
      '''            
██╗    ██╗██╗██╗  ██╗██╗██████╗ ███████╗██████╗ ██╗ █████╗ 
██║    ██║██║██║ ██╔╝██║██╔══██╗██╔════╝██╔══██╗██║██╔══██╗
██║ █╗ ██║██║█████╔╝ ██║██████╔╝█████╗  ██║  ██║██║███████║
██║███╗██║██║██╔═██╗ ██║██╔═══╝ ██╔══╝  ██║  ██║██║██╔══██║
╚███╔███╔╝██║██║  ██╗██║██║     ███████╗██████╔╝██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝'''.white.center;

  static String narrowWindowTitle =
      'Welcome to\nDart Wikipedia!'.center.displayText;

  static String enterACommand = 'Enter a command to continue.'.instructionText;

  // Article related

  static String summary(Summary summary) {
    return [
      '\n${summary.titles.normalized.headerText} - ${summary.description}\n',
      summary.extract.bodyText.splitLinesByLength(50).join('\n'),
      '\nRead more: ${summary.url}'.applyStyles(faint: true),
    ].join('\n');
  }

  static String articleInstructions =
      [
        "'r' for another random article",
        "'q' to return to menu",
      ].join('\n').instructionText;

  // Timeline related

  static String onFirstEvent =
      "On first event, wrapping to end of list".errorText;

  static String endOfList =
      'End of event list, wrapping to the beginning of list'.errorText;

  static String enterLeftOrRight =
      ' <- or -> to navigate, q to quit'.instructionText;

  static String eventNumber(int idx, int timelineLength) =>
      'Event ${idx + 1}/$timelineLength\n'.applyStyles(faint: true);

  static String event(OnThisDayEvent event) {
    var strBuffer = StringBuffer('\n');
    strBuffer.write(" * ".headerText);
    if (event.year != null) {
      strBuffer.write(event.year.toString().headerText);
    } else {
      strBuffer.write('Holiday'.headerText);
    }
    strBuffer.write('\n\n');
    var text = event.text.splitLinesByLength(50);
    for (var line in text) {
      strBuffer.write('   $line\n'.bodyText);
    }
    return strBuffer.toString();
  }

  // Error texts
  static String unknownInput = 'Unknown input.'.errorText;

  static String invalidArgs(Args arg) {
    var base = 'Invalid args for command.'.errorText;
    base += '\nUsage:\n$arg';
    return base;
  }

  static String inputExists(String name) =>
      'Input $name already exists.'.errorText;

  static String wikipediaHttpError(HttpException e) {
    return [
      'Unable to fetch article from Wikipedia'.errorText,
      'Message: ${e.message}',
    ].join('\n');
  }
}
