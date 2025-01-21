import 'console/console.dart';

extension StyleText on String {
  // ColorTheme text styles
  // For dark-mode themed terminals
  String get errorText => applyStyles(foreground: ConsoleColor.red);
  String get displayTextLight =>
      applyStyles(foreground: ConsoleColor.dartPrimaryLight, bold: true);
  String get instructionTextLight =>
      applyStyles(foreground: ConsoleColor.white, italic: true);

  // Text color
  String get red => ConsoleColor.red.applyForeground(this);
  String get darkBlue => ConsoleColor.dartPrimaryDark.applyForeground(this);
  String get lightBlue => ConsoleColor.dartPrimaryLight.applyForeground(this);
  String get yellow => ConsoleColor.yellow.applyForeground(this);
  String get teal => ConsoleColor.teal.applyForeground(this);
  String get white => ConsoleColor.white.applyForeground(this);

  // Text background colors
  String get darkBlueBackground =>
      ConsoleColor.dartPrimaryDark.applyBackground(this);
  String get lightBlueBackground =>
      ConsoleColor.dartPrimaryDark.applyBackground(this);
  String get whiteBackground => ConsoleColor.white.applyBackground(this);

  // Styles
  String get bold => ConsoleTextStyle.bold.apply(this);
  String get italicize => ConsoleTextStyle.italic.apply(this);
  String get blinking => ConsoleTextStyle.blink.apply(this);
}
