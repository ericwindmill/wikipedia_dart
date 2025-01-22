import 'console/console.dart';

extension StyleText on String {
  // For dark-mode themed terminals
  String get headerText =>
      applyStyles(foreground: ConsoleColor.lightBlue, bold: true);
  String get displayText =>
      applyStyles(foreground: ConsoleColor.flutterBlue, bold: true);
  String get titleText => flutterBlue.applyStyles(bold: true, underscore: true);
  String get bodyText => grey;
  String get instructionText => yellow.applyStyles(italic: true);
  String get errorText => red;

  // Text color
  String get red => ConsoleColor.red.applyForeground(this);
  String get dartBlue => ConsoleColor.dartBlue.applyForeground(this);
  String get flutterBlue => ConsoleColor.flutterBlue.applyForeground(this);
  String get lightBlue => ConsoleColor.lightBlue.applyForeground(this);
  String get yellow => ConsoleColor.yellow.applyForeground(this);
  String get white => ConsoleColor.white.applyForeground(this);
  String get grey => ConsoleColor.grey.applyForeground(this);

  // Text background colors
  String get darkBlueBackground => ConsoleColor.dartBlue.applyBackground(this);
  String get lightBlueBackground => ConsoleColor.dartBlue.applyBackground(this);
  String get whiteBackground => ConsoleColor.white.applyBackground(this);

  // Styles
  String get bold => ConsoleTextStyle.bold.apply(this);
  String get italicize => ConsoleTextStyle.italic.apply(this);
  String get blinking => ConsoleTextStyle.blink.apply(this);
}
