import 'dart:io';
import 'package:cli/src/console/console.dart';
import 'package:cli/src/style_text.dart';
import 'package:shared/wikipedia_api.dart';

import '../app.dart';
import '../outputs.dart';

part 'help.dart';
part 'timeline.dart';
part 'quit.dart';

sealed class Command<T> {
  String get description;
  String get name;
  List<String> get aliases;
  late InteractiveCommandRunner runner;
  Stream<T> run({List<String>? args});

  String get usage {
    var buffer = StringBuffer()..writeAll([name, ...aliases], ', ');
    return '${buffer.toString()} - $description';
  }
}

mixin Args on Command<String> {
  String get argName;
  String get argHelp;
  bool get required => false;
  String? get argDefault;

  bool validateArgs(List<String>? args) {
    if (required && args == null || required && args!.isEmpty) return false;
    for (var arg in args!) {
      if (!arg.contains('=')) return false;
    }
    return true;
  }

  @override
  String get usage {
    var buffer = StringBuffer('$name, ')..writeAll(aliases, ', ');

    buffer.write(' - $argName=$argHelp ');
    if (required) {
      buffer.write(' [required] ');
    }

    var defaultVal = argDefault != null ? ' default: $argDefault' : '';
    buffer.write(defaultVal);

    buffer.write('\n$description');
    return buffer.toString();
  }
}
