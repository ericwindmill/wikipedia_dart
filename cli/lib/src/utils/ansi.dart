import 'package:io/ansi.dart' as ansi;

extension Stylize on String {
  // Foreground colors
  String lightGray() => ansi.lightGray.wrap(this)!;
  String red() => ansi.red.wrap(this)!;
  String black() => ansi.black.wrap(this)!;
  String cyan() => ansi.cyan.wrap(this)!;
  String blue() => ansi.blue.wrap(this)!;
  String yellow() => ansi.yellow.wrap(this)!;

  // Background colors
  String darkGrayBackground() => ansi.backgroundDarkGray.wrap(this)!;
  String cyanBackground() => ansi.backgroundCyan.wrap(this)!;
  String greenBackground() => ansi.backgroundGreen.wrap(this)!;
  String yellowBackground() => ansi.backgroundYellow.wrap(this)!;
  String magentaBackground() => ansi.backgroundLightMagenta.wrap(this)!;

  // Font styles
  String bold() => ansi.styleBold.wrap(this)!;
  String italicize() => ansi.styleItalic.wrap(this)!;
  String blinking() => ansi.styleBlink.wrap(this)!;

  String defaultTextStyle() =>
      ansi.wrapWith(this, [ansi.defaultForeground, ansi.backgroundDefault])!;
}
