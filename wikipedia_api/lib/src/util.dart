bool verifyMonthAndDate({required String month, required String date}) {
  var monthAsInt = num.parse(month);
  var dateAsInt = num.parse(date);

  final longMonths = [1, 3, 5, 7, 8, 10, 12];
  final shortMonths = [4, 6, 9, 11];
  if (monthAsInt < 1 || monthAsInt > 12) return false;
  if (dateAsInt < 1) return false;
  if (longMonths.contains(monthAsInt)) {
    if (dateAsInt > 31) return false;
  } else if (shortMonths.contains(30)) {
    if (dateAsInt > 30) return false;
  } else {
    if (dateAsInt > 29) return false;
  }

  return true;
}

String toStringWithPad(int number) {
  if (number < 10) {
    return number.toString().padLeft(2, '0');
  }

  return number.toString();
}
