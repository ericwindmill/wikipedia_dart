bool verifyMonthAndDate({required int month, required int day}) {
  final longMonths = [1, 3, 5, 7, 8, 10, 12];
  final shortMonths = [4, 6, 9, 11];
  if (month < 1 || month > 12) return false;
  if (day < 1) return false;
  if (longMonths.contains(month)) {
    if (day > 31) return false;
  } else if (shortMonths.contains(30)) {
    if (day > 30) return false;
  } else {
    if (day > 29) return false;
  }

  return true;
}

String toStringWithPad(int number) {
  if (number < 10) {
    return number.toString().padLeft(2, '0');
  }

  return number.toString();
}

Map<int, String> months = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

extension Readable on DateTime {
  String get humanReadable {
    return '${months[month]} $day';
  }
}

/// Turns ints into Strings with BCE
/// if the year is negative
extension ReadableYear on int {
  String get absYear {
    if (this < 0) {
      return '${abs()} BCE';
    }

    return abs().toString();
  }
}

extension SplitByLength on String {
  List<String> splitLinesByLength(int length) {
    var words = split(' ');
    var output = <String>[];
    var strBuffer = StringBuffer();
    for (var i = 0; i < words.length; i++) {
      var word = words[i];
      if (strBuffer.length + word.length <= length) {
        strBuffer.write(word);
        if (strBuffer.length + 1 <= length) {
          strBuffer.write(' ');
        }
      }
      // If the next word surpasses length, start the next line
      if (i + 1 < words.length &&
          words[i + 1].length + strBuffer.length + 1 > length) {
        output.add(strBuffer.toString());
        strBuffer.clear();
      }
    }

    // Add left overs
    output.add(strBuffer.toString());
    return output;
  }
}
