import 'dart:math' as math;

import '../app.dart';
import '../console/console.dart';

abstract class Command<T> {
  String get description;
  String get name;
  List<String> get aliases;

  late InteractiveCommandRunner<T> runner;

  Stream<T> run({List<String>? args});

  @override
  String toString() {
    final int maxWidth = console.windowWidth;
    final List<int> columns = <int>[
      math.min(25, (maxWidth * .25).floor()),
      math.min(25, (maxWidth * .25).floor()),
      (maxWidth * .5).floor(),
    ];

    final String cmd = <String>[
      name,
      ...aliases,
    ].join(', ');
    final StringBuffer buffer =
        StringBuffer()
          ..write('$cmd${' ' * columns.first} ')
          ..write(' ' * columns[1])
          ..write(description);
    return buffer.toString();
  }
}

mixin Args on Command<String> {
  String get argName;
  String get argHelp;
  bool get argRequired => false;
  String? get argDefault;

  bool validateArgs(List<String>? args) {
    if (argRequired && args == null ||
        argRequired && args!.isEmpty) {
      return false;
    }
    for (final String arg in args!) {
      if (!arg.contains('=')) return false;
    }
    return true;
  }

  @override
  String toString() {
    final int maxWidth = console.windowWidth;
    final List<int> columns = <int>[
      math.min(25, (maxWidth * .25).floor()),
      math.min(25, (maxWidth * .25).floor()),
      (maxWidth * .5).floor(),
    ];

    final String cmd = <String>[
      name,
      ...aliases,
    ].join(', ');
    final StringBuffer buffer =
        StringBuffer()
          ..write('$cmd${' ' * columns.first} ')
          ..write('$argName=$argName${' ' * columns[1]}')
          ..write(description);
    return buffer.toString();
  }
}
