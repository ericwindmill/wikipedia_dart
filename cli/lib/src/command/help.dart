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
  int _newLines = 0;
  final List<String> columns = ['Command', 'Args', 'Descriptions'];

  @override
  Stream<String> run({List<String>? args}) async* {
    // 3 columns: Command, Args, Description
    List<int> colWidths = _columnWidths();

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
      var i = 0;
      while (i < numLines) {
        var start =
            i == 0
                ? 0
                : colWidths.take(i).reduce((start, col) => start + col + 1);
        var nameLine = nameSplit.elementAtOrNull(i) ?? '';
        _writeString(nameLine, colWidths[0], 0);
        var argLine = argSplit.elementAtOrNull(i) ?? '';
        _writeString(argLine, colWidths[1], start);
        var descLine = descSplit.elementAtOrNull(i) ?? '';
        _writeString(descLine, colWidths[1], start);
        i++;
      }
      // _buffer.write('\n');
      yield _buffer.toString();
      _buffer.clear();
    }
  }

  void _writeString(String str, int colWidth, int start) {
    _buffer.write('$str${' ' * (colWidth - str.length)} ');
    // var lineCount = 0;
    // // The lines need to be wrapped if the str is too long
    // if (str.length > colWidth) {
    //   // List<String> lines = str.splitLinesByLength(colWidth);
    //   // _buffer.write('${lines.first}\n');
    //   // lineCount++;
    //   // for (var line in lines.sublist(1)) {
    //   //   _buffer.write(' ' * start);
    //   //   _buffer.write('$line\n');
    //   //   lineCount++;
    //   // }
    //   // if (lineCount > _newLines) _newLines = lineCount;
    // } else {
    //   // If the str is less than the column width
    //
    // }
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
}
