part of 'command.dart';

class HelpCommand extends Command<String> {
  @override
  String get name => 'help';

  @override
  String get description => 'Prints this usage information.';

  @override
  List<String> get aliases => ['h'];

  final int _maxWidth = 80;
  final StringBuffer _buffer = StringBuffer();
  final List<String> columns = ['Command', 'Args', 'Descriptions'];
  final String separator = ' | ';

  @override
  Stream<String> run({List<String>? args}) async* {
    // 3 columns: Command, Args, Description
    List<int> colWidths = _columnWidths();
    yield 'Welcome to Dart Wikipedia. Enter a command to continue. \n'.bold;

    yield* _header(colWidths);
    for (var c in runner.commands) {
      var items = c.usage;
      var nameSplit = items[0].splitLinesByLength(colWidths[0]);
      var argSplit = [items[1], items[2]];
      var descSplit = items[3].splitLinesByLength(colWidths[2]);
      var numLines = max(
        nameSplit.length,
        max(descSplit.length, argSplit.length),
      );

      // Create a single line
      var cols = <String>[];
      var i = 0;
      while (i < numLines) {
        var nameLine = nameSplit.elementAtOrNull(i) ?? '';
        cols.add('$nameLine${' ' * (colWidths[i] - nameLine.length)} ');
        var argLine = argSplit.elementAtOrNull(i) ?? '';
        cols.add('$argLine${' ' * (colWidths[i] - argLine.length)} ');
        var descLine = descSplit.elementAtOrNull(i) ?? '';
        cols.add('$descLine${' ' * (colWidths[i] - descLine.length)} ');

        var isBlankLine = cols.every((element) => element.trim().isEmpty);
        if (!isBlankLine) {
          _buffer.writeAll(cols, separator);
          yield _buffer.toString();
        }

        _buffer.clear();
        cols.clear();
        i++;
      }
    }
  }

  List<int> _columnWidths() {
    int commandColLength = 0;
    int argsColLength = 0;
    int descriptionColLength = 0;
    for (var c in runner.commands) {
      var items = c.usage;
      assert(items.length == columns.length + 1);
      commandColLength = max(commandColLength, items[0].length);

      /// argsColLength is either the length of the arg, or the default value
      argsColLength = max(argsColLength, items[1].length);
      argsColLength = max(argsColLength, items[2].length);

      descriptionColLength = max(descriptionColLength, items[3].length);
    }

    /// If the sum of the columns > maxWidth, cut description short enough to fit
    descriptionColLength = min(
      descriptionColLength,
      _maxWidth - commandColLength - argsColLength,
    );

    return [commandColLength, argsColLength, descriptionColLength];
  }

  Stream<String> _header(List<int> columnWidths) async* {
    var buffer = StringBuffer();
    var cols = [];

    for (var i = 0; i < columns.length; i++) {
      cols.add('${columns[i]}${' ' * (columnWidths[i] - columns[i].length)} ');
    }
    buffer.writeAll(cols, ' | ');
    yield buffer.toString();
    yield '-' * columnWidths.reduce((start, col) => start + col);
  }
}
