part of 'console.dart';

enum Border {
  none('', '', '', '', '', '', '', '', '', '', ''),
  ascii('-', '|', '-', '-', '-', '-', '+', '-', '-', '|', '|'),
  fancy('─', '│', '┌', '┐', '└', '┘', '┼', '┴', '┬', '┤', '├');

  const Border(
    this.horizontalLine,
    this.verticalLine,
    this.topLeftCorner,
    this.topRightCorner,
    this.bottomLeftCorner,
    this.bottomRightCorner,
    this.cross,
    this.teeUp,
    this.teeDown,
    this.teeLeft,
    this.teeRight,
  );
  final String horizontalLine;
  final String verticalLine;
  final String topLeftCorner;
  final String topRightCorner;
  final String bottomLeftCorner;
  final String bottomRightCorner;
  final String cross;
  final String teeUp;
  final String teeDown;
  final String teeLeft;
  final String teeRight;
}

class Table {
  Table({
    this.title = '',
    this.textColor = ConsoleColor.white,
    this.borderColor = ConsoleColor.white,
    this.headerColor = ConsoleColor.white,
    this.headerTextStyles = const <ConsoleTextStyle>[],
    this.titleColor = ConsoleColor.white,
    this.titleTextStyles = const <ConsoleTextStyle>[],
    this.border = Border.none,
  });

  final String title;
  final ConsoleColor textColor;
  final ConsoleColor borderColor;
  final ConsoleColor headerColor;
  final List<ConsoleTextStyle> headerTextStyles;
  final ConsoleColor titleColor;
  final List<ConsoleTextStyle> titleTextStyles;
  final Border border;

  int get maxWidth => console.windowWidth;

  int get rows => _table.length - 1;

  // The length of one row
  int get columns => _table[0].length;

  List<int> _columnWidths = <int>[];

  final List<List<Object>> _table = <List<Object>>[];

  bool _hasHeader = false;

  bool get _hasBorder => border != Border.none;

  bool get _hasTitle => title != '';

  void setHeaderRow(List<Object> row) {
    insertRow(row, index: 0);
    _hasHeader = true;
    assert(
      tableIntegrity,
      'Each row in a table should have the same number of columns.',
    );
  }

  void insertRow(List<Object> row, {int? index}) {
    if (index != null && index <= rows) {
      _table.insert(index, row);
    } else {
      _table.add(row);
    }
    _columnWidths = _calculateColumnWidths();
    assert(
      tableIntegrity,
      'Each row in a table should have the same number of columns.',
    );
  }

  void insertRows(List<List<Object>> newRows, {int? index}) {
    int i = index ?? rows;
    for (final List<Object> row in newRows) {
      insertRow(row, index: i);
      i++;
    }
  }

  /// Make sure that each row in the table has an equal number of columns
  bool get tableIntegrity {
    return _table.every((List<Object> row) => row.length == columns) &&
        columns == _columnWidths.length;
  }

  String render() {
    final StringBuffer buffer = StringBuffer();
    final int tableWidth = _calculateTableWidth();
    _columnWidths = _calculateColumnWidths();

    if (_hasTitle) {
      buffer.write(_renderTitle(tableWidth));
    }

    // This border is the top not including title rows.
    buffer.write(_tableTopBorder());

    if (_hasHeader) {
      final List<Object> currentRow = _table[0];
      buffer
        ..write(
          _row(currentRow, textColor: headerColor, styles: headerTextStyles),
        )
        ..write(_innerBorderRow());
    }

    for (int i = 1; i <= rows; i++) {
      buffer.write(_row(_table[i], textColor: textColor));
      if (i < rows) buffer.write(_innerBorderRow());
    }

    buffer.write(_tableBottomBorder());

    return buffer.toString();
  }

  @override
  String toString() => render();

  int _calculateTableWidth() {
    if (_table[0].isEmpty) return 0;
    final int widths = _combineWidths(_calculateColumnWidths());
    return widths + _borderWidth();
  }

  int _combineWidths(List<int> columnWidths) =>
      columnWidths.reduce((int start, int colWidth) => start + colWidth);

  int _borderWidth() {
    if (!_hasBorder) {
      return columns - 1;
    } else {
      return 4 + (3 * (columns - 1));
    }
  }

  List<int> _calculateColumnWidths() {
    // for every column, look at each value in the column and take the max
    final List<int> widths = List<int>.generate(columns, (int col) {
      int maxWidth = 0;
      for (final List<Object> row in _table) {
        maxWidth = math.max(maxWidth, row[col].toString().length);
      }
      return maxWidth;
    }, growable: false);

    return _adjustColumnWidthsForWindowSize(widths);
  }

  // Reduces the length of 'wide' columns such that a table will fit in
  // the existing terminal window. Wide columns are made equal in size,
  // taking up the space left over after accounting for 'narrow' columns.
  // Wide and narrow columns are defined by their relationship to
  // the width of a column if every column had an equal width.
  // i.e. Wide columns have a greater length
  // than (roughly)  windowWidth / numColumns, while narrow columns
  // have a less than or equivalent length.
  //
  // There's almost certainly a better way to do this.
  // If this were a coding interview, I'm sure I would fail
  List<int> _adjustColumnWidthsForWindowSize(List<int> columnWidths) {
    final int borderLength = _borderWidth();
    final int tableWidth = _combineWidths(columnWidths) + borderLength;
    if (tableWidth <= maxWidth) return columnWidths;

    if (columnWidths.length == 1) {
      columnWidths.first = maxWidth - borderLength;
      return columnWidths;
    }

    // This provides a basis for which columns should be adjusted
    final int evenColumnWidth = (maxWidth / columns).floor();

    // separate wide columns and narrow columns
    final List<int> wideColumnLengths =
        columnWidths
            .where((int colLength) => colLength > evenColumnWidth)
            .toList();
    final List<int> narrowColumnLengths =
        columnWidths
            .where((int colLength) => colLength <= evenColumnWidth)
            .toList();

    // find the total available width after accounting for narrow columns
    final int totalAvailableWidth =
        maxWidth - borderLength - _combineWidths(narrowColumnLengths);

    // divide that available width among the width columns
    final Iterable<int> wideColumnIndexes = wideColumnLengths.map(
      (int colLength) => columnWidths.indexOf(colLength),
    );
    final int newLongColumnLength =
        (totalAvailableWidth / wideColumnIndexes.length).floor();
    for (final int col in wideColumnIndexes) {
      columnWidths[col] = newLongColumnLength;
    }

    return columnWidths;
  }

  String _rowStart() {
    if (!_hasBorder) return '';

    return '${border.verticalLine.applyStyles(foreground: borderColor)} ';
  }

  String _rowEnd() {
    if (!_hasBorder) return '\n';

    return ' ${border.verticalLine.applyStyles(foreground: borderColor)}\n';
  }

  String _rowDelimiter() {
    if (!_hasBorder) return ' ';

    return ' ${border.verticalLine.applyStyles(foreground: borderColor)} ';
  }

  String _row(
    List<Object> row, {
    ConsoleColor textColor = ConsoleColor.white,
    List<ConsoleTextStyle> styles = const <ConsoleTextStyle>[],
  }) {
    // row data after being split to fit in column lengths
    final List<List<String>> splitEntries = <List<String>>[];
    int i = 0;
    while (i < row.length) {
      final String entry = row[i].toString();
      final int colLength = _columnWidths[i];
      splitEntries.add(entry.splitLinesByLength(colLength));
      i++;
    }

    // This method will return a string that could represent more than one
    // row, if any entries are longer then their allowed column width
    int rowHeight = 1;
    for (final List<String> row in splitEntries) {
      rowHeight = math.max(rowHeight, row.length);
    }
    final List<String> newRows = List<String>.filled(rowHeight, '');

    // grab the first element of each splitEntry to make row one
    for (int index = 0; index < newRows.length; index++) {
      final List<String> newRowInner = <String>[];
      for (int col = 0; col < columns; col++) {
        final List<String> entry = splitEntries[col];
        String rowValue = '';
        if (index < entry.length) {
          rowValue = entry[index];
        }
        for (final ConsoleTextStyle style in styles) {
          rowValue = style.apply(rowValue);
        }
        newRowInner.add(
          _cellEntry(
            rowValue.applyStyles(foreground: textColor),
            _columnWidths[col],
          ),
        );
      }

      newRows[index] =
          <String>[
            _rowStart(),
            newRowInner.join(_rowDelimiter()),
            _rowEnd(),
          ].join();
    }

    return newRows.join();
  }

  String _cellEntry(String value, int columnWidth) {
    final int numSpaces = columnWidth - value.strip.length;
    return '$value${' ' * numSpaces}';
  }

  String _tableTopBorder() {
    if (!_hasBorder) return '';

    String delimiter;
    delimiter =
        '${border.horizontalLine}${border.teeDown}${border.horizontalLine}';

    return <String>[
      borderColor.enableForeground,
      if (_hasTitle) border.teeRight else border.topLeftCorner,
      border.horizontalLine,
      _columnWidths
          .map((int width) => border.horizontalLine * width)
          .join(delimiter),
      border.horizontalLine,
      if (_hasTitle) border.teeLeft else border.topRightCorner,
      ConsoleColor.reset,
      '\n',
    ].join();
  }

  String _tableBottomBorder() {
    if (!_hasBorder) return '';

    String delimiter;
    delimiter =
        '${border.horizontalLine}${border.teeUp}${border.horizontalLine}';

    return <String>[
      borderColor.enableForeground,
      border.bottomLeftCorner,
      border.horizontalLine,
      _columnWidths
          .map((int width) => border.horizontalLine * width)
          .join(delimiter),
      border.horizontalLine,
      border.bottomRightCorner,
      ConsoleColor.reset,
      '\n',
    ].join();
  }

  // Top, not including above the title
  String _innerBorderRow() {
    if (!_hasBorder) return '';

    final String delimiter =
        '${border.horizontalLine}${border.cross}${border.horizontalLine}';

    return <String>[
      borderColor.enableForeground,
      border.teeRight,
      border.horizontalLine,
      _columnWidths
          .map((int width) => border.horizontalLine * width)
          .join(delimiter),
      border.horizontalLine,
      border.teeLeft,
      ConsoleColor.reset,
      '\n',
    ].join();
  }

  String _renderTitle(int tableWidth) {
    final StringBuffer buffer = StringBuffer();
    String styledTitle = title;
    for (final ConsoleTextStyle style in titleTextStyles) {
      styledTitle = style.apply(styledTitle);
    }
    if (_hasBorder) {
      buffer.writeAll(<String>[
        borderColor.enableForeground,
        border.topLeftCorner,
        border.horizontalLine * (tableWidth - 2),
        border.topRightCorner,
        ConsoleColor.reset,
        '\n',
      ]);
    }
    buffer.writeAll(<String>[
      _rowStart(),
      titleColor.enableForeground,
      _cellEntry(styledTitle, tableWidth - 4),
      ConsoleColor.reset,
      _rowEnd(),
      if (!_hasBorder) '\n',
    ]);
    return buffer.toString();
  }
}
