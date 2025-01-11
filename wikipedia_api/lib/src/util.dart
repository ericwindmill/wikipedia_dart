bool verifyMonthAndDate({required int month, required int day}) {
  final longMonths = [1, 3, 5, 7, 8, 10, 12];
  final shortMonths = [4, 6, 9, 11];
  if (month < 1 || day > 12) return false;
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
