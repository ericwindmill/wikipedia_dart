import 'dart:io';

Future<String?> prompt(String input) async {
  await _delayedPrint(input);
  return stdin.readLineSync();
}

Future<void> _delayedPrint(String text, {int duration = 200}) async {
  return await Future.delayed(
    Duration(milliseconds: duration),
    () => print(text),
  );
}

/// [duration] defines how much time there will be between each line print (in milliseconds).
Future<void> write(String text, {int duration = 100}) async {
  var lines = text.split('\n');
  for (var l in lines) {
    await _delayedPrint(l, duration: duration);
  }
}
