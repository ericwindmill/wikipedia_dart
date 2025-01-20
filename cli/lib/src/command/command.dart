import 'dart:io';
import 'dart:math';

import 'package:cli/src/console/io_utils.dart';
import 'package:shared/wikipedia_api.dart';

import '../../wikipedia_cli.dart';
import '../outputs.dart';
import '../console/style_text.dart';

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
