import 'package:cli/src/app.dart';
import 'package:cli/src/command/command.dart';

void main(List<String> arguments) async {
  var app = InteractiveCommandRunner<String>()..addCommand(TimelineCommand());
  app.run();
}
