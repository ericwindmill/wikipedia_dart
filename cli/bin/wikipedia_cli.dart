import 'package:cli/src/app.dart';

void main(List<String> arguments) async {
  var app = InteractiveCommandRunner<String>();
  app.run();
}
