import 'package:shared/wikipedia_api.dart';

import './utils/style_text.dart';

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
 '''.dartBlue.bold;

  static final wikipediaTitle =
      '''            
██╗    ██╗██╗██╗  ██╗██╗██████╗ ███████╗██████╗ ██╗ █████╗ 
██║    ██║██║██║ ██╔╝██║██╔══██╗██╔════╝██╔══██╗██║██╔══██╗
██║ █╗ ██║██║█████╔╝ ██║██████╔╝█████╗  ██║  ██║██║███████║
██║███╗██║██║██╔═██╗ ██║██╔═══╝ ██╔══╝  ██║  ██║██║██╔══██║
╚███╔███╔╝██║██║  ██╗██║██║     ███████╗██████╔╝██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝ 
 '''.bold;

  static String event(OnThisDayEvent event) {
    var strBuffer = StringBuffer(" * FIX ".red.bold);
    if (event.year != null) {
      // strBuffer.write(event.year.toString().blue().bold());
    } else {
      // strBuffer.write('Holiday'.blue().bold());
    }
    strBuffer.write('\n');
    var text = event.text.splitLinesByLength(50);
    for (var line in text) {
      strBuffer.write('$line\n');
    }
    return strBuffer.toString();
  }
}
