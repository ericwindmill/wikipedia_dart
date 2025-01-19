import 'dart:math';

import 'package:shared/wikipedia_api.dart';

import '../../wikipedia_cli.dart';
import '../outputs.dart';
import '../utils/print_utils.dart';

part 'help.dart';
part 'timeline.dart';
part 'quit.dart';

sealed class Command<T> {
  String get description;
  String get name;
  List<String> get aliases;
  late InteractiveCommandRunner runner;
  Stream<T> run({List<String>? args});

  /// Returns the pieces of usage, formatted
  /// Pieces are [name(s), args, defaultArg, description].
  List<String> get usage {
    var buffer = StringBuffer()..writeAll(aliases, ', ');
    return ['$name, ${buffer.toString()}', '', '', description];
  }
}

mixin Args on Command<String> {
  String get argName;
  String get argHelp;
  bool get required => false;
  String? get argDefault;

  /// Returns the pieces of usage, formatted
  /// Pieces are [name(s), args, defaultArg, description].
  @override
  List<String> get usage {
    var buffer = StringBuffer('$name, ')..writeAll(aliases, ', ');
    var colA = buffer.toString();
    buffer.clear();

    if (required) {
      buffer.write('[required] ');
    }
    buffer.write('$argName=$argHelp');

    var defaultVal = argDefault != null ? 'default: $argDefault' : '';

    return [colA, buffer.toString(), defaultVal, description];
  }
}
