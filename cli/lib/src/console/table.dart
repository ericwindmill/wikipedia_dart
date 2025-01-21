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
    this.headerTextStyles = const [],
    this.titleColor = ConsoleColor.white,
    this.titleTextStyles = const [],
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

  /// The length of one row
  int get columns => _table[0].length;

  List<int> _columnWidths = [];
  final List<List<Object>> _table = [];
  bool _hasHeader = false;

  void setHeaderRow(List<Object> row) {
    insertRow(row, index: 0);
    _hasHeader = true;
  }

  void insertRow(List<Object> row, {int? index}) {
    if (index != null && index <= rows) {
      _table.insert(index, row);
    } else {
      _table.add(row);
    }
    _columnWidths = _calculateColumnWidths();
  }

  void insertRows(List<List<Object>> newRows, {int? index}) {
    var i = index ?? rows;
    for (var row in newRows) {
      insertRow(row, index: i);
      i++;
    }
  }

  bool get tableIntegrity {
    return _table.every((row) => row.length == columns) &&
        columns == _columnWidths.length;
  }

  String render() {
    StringBuffer buffer = StringBuffer();
    var tableWidth = _calculateTableWidth();
    _columnWidths = _calculateColumnWidths();

    if (_hasTitle) {
      buffer.write(_renderTitle(tableWidth));
    }
    // Top border (not including title)
    buffer.write(_tableTopBorder());

    if (_hasHeader) {
      var currentRow = _table[0];
      buffer.write(
        _row(currentRow, textColor: headerColor, styles: headerTextStyles),
      );
      buffer.write(_innerBorderRow());
    }

    for (var i = 1; i <= rows; i++) {
      buffer.write(_row(_table[i], textColor: textColor));
      if (i < rows) buffer.write(_innerBorderRow());
    }

    buffer.write(_tableBottomBorder());

    return buffer.toString();
  }

  @override
  String toString() => render();

  bool get _hasBorder => border != Border.none;
  bool get _hasTitle => title != '';

  int _calculateTableWidth() {
    if (_table[0].isEmpty) return 0;
    var widths = _combineWidths(_calculateColumnWidths());
    return widths + _borderWidth();
  }

  int _combineWidths(List<int> columnWidths) =>
      columnWidths.reduce((start, colWidth) => start + colWidth);

  int _borderWidth() {
    if (!_hasBorder) {
      return columns - 1;
    } else {
      return 4 + (3 * (columns - 1));
    }
  }

  List<int> _calculateColumnWidths() {
    // for every column, look at each value in the column and take the max
    var widths = List.generate(columns, (col) {
      int maxWidth = 0;
      for (var row in _table) {
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
  // i.e. Wide columns have a greater length, while narrow columns
  // have a less than or equivalent length.
  List<int> _adjustColumnWidthsForWindowSize(List<int> columnWidths) {
    var borderLength = _borderWidth();
    var tableWidth = _combineWidths(columnWidths) + borderLength;
    if (tableWidth <= maxWidth) return columnWidths;

    if (columnWidths.length == 1) {
      columnWidths.first = maxWidth - borderLength;
      return columnWidths;
    }

    // This provides a basis for which columns should be adjusted
    var evenColumnWidth = (maxWidth / columns).floor();

    // separate long columns and short columns
    var wideColumnLengths =
        columnWidths.where((colLength) => colLength > evenColumnWidth).toList();
    var narrowColumnLengths =
        columnWidths
            .where((colLength) => colLength <= evenColumnWidth)
            .toList();

    // find the total available width, which is the table width
    // (the combined short column width)
    var totalAvailableWidth =
        maxWidth - borderLength - _combineWidths(narrowColumnLengths);

    // (divide that available width among the width columns)
    var wideColumnIndexes = wideColumnLengths.map(
      (colLength) => columnWidths.indexOf(colLength),
    );
    var newLongColumnLength =
        (totalAvailableWidth / wideColumnIndexes.length).floor();
    for (var col in wideColumnIndexes) {
      columnWidths[col] = newLongColumnLength;
    }

    return columnWidths;
  }

  // Top, not including above the title
  String _innerBorderRow() {
    if (!_hasBorder) return '';

    var delimiter =
        '${border.horizontalLine}${border.cross}${border.horizontalLine}';

    return [
      borderColor.enableForeground,
      border.teeRight,
      border.horizontalLine,
      _columnWidths
          .map((width) => border.horizontalLine * width)
          .join(delimiter),
      border.horizontalLine,
      border.teeLeft,
      ConsoleColor.reset,
      '\n',
    ].join();
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
    List<ConsoleTextStyle> styles = const [],
  }) {
    // row data after being split to fit in column lengths
    var splitEntries = <List<String>>[];
    var i = 0;
    while (i < row.length) {
      var entry = row[i].toString();
      var colLength = _columnWidths[i];
      splitEntries.add(entry.splitLinesByLength(colLength));
      i++;
    }

    // This method will return a string that could represent more than one
    // row, if any entries are longer then their allowed column width
    var rowHeight = 1;
    for (var row in splitEntries) {
      rowHeight = math.max(rowHeight, row.length);
    }
    List<String> newRows = List.filled(rowHeight, '');

    // grab the first element of each splitEntry to make row one
    for (var index = 0; index < newRows.length; index++) {
      var newRowInner = [];
      for (var col = 0; col < columns; col++) {
        var entry = splitEntries[col];
        var rowValue = '';
        if (index < entry.length) {
          rowValue = entry[index];
        }
        for (var style in styles) {
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
          [_rowStart(), newRowInner.join(_rowDelimiter()), _rowEnd()].join();
    }

    return newRows.join();
  }

  String _cellEntry(String value, int columnWidth) {
    var numSpaces = columnWidth - value.strip.length;
    return '$value${' ' * numSpaces}';
  }

  String _tableTopBorder() {
    if (!_hasBorder) return '';

    String delimiter;
    delimiter =
        '${border.horizontalLine}${border.teeDown}${border.horizontalLine}';

    return [
      borderColor.enableForeground,
      _hasTitle ? border.teeRight : border.topLeftCorner,
      border.horizontalLine,
      _columnWidths
          .map((width) => border.horizontalLine * width)
          .join(delimiter),
      border.horizontalLine,
      _hasTitle ? border.teeLeft : border.topRightCorner,
      ConsoleColor.reset,
      '\n',
    ].join();
  }

  String _tableBottomBorder() {
    if (!_hasBorder) return '';

    String delimiter;
    delimiter =
        '${border.horizontalLine}${border.teeUp}${border.horizontalLine}';

    return [
      borderColor.enableForeground,
      border.bottomLeftCorner,
      border.horizontalLine,
      _columnWidths
          .map((width) => border.horizontalLine * width)
          .join(delimiter),
      border.horizontalLine,
      border.bottomRightCorner,
      ConsoleColor.reset,
      '\n',
    ].join();
  }

  String _renderTitle(int tableWidth) {
    var buffer = StringBuffer();
    String styledTitle = title;
    for (var style in titleTextStyles) {
      styledTitle = style.apply(styledTitle);
    }
    if (_hasBorder) {
      buffer.writeAll([
        borderColor.enableForeground,
        border.topLeftCorner,
        border.horizontalLine * (tableWidth - 2),
        border.topRightCorner,
        ConsoleColor.reset,
        '\n',
      ]);
    }
    buffer.writeAll([
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

extension Indexed<T> on List<T> {
  /// Maps each element of the list.
  /// The [map] function gets both the original [item] and its [index].
  Iterable<E> mapIndexed<E>(E Function(int index, T item) map) sync* {
    for (var index = 0; index < length; index++) {
      yield map(index, this[index]);
    }
  }
}
