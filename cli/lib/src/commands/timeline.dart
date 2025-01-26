import 'package:cli/src/model/command.dart';
import 'package:cli/src/outputs.dart';
import 'package:cli/src/utils/timeout.dart';
import 'package:cli/wikipedia_cli.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelineCommand extends Command<String> with Args {
  @override
  String get name => 'timeline';

  @override
  List<String> get aliases => <String>['t'];

  @override
  String get description =>
      'Lists historic events that happened on the given date.';

  @override
  String get argHelp => 'MM/DD';

  @override
  String get argName => 'date';

  @override
  bool get argRequired => false;

  @override
  String get argDefault {
    final DateTime today = DateTime.now();
    final String month = today.month.toString();
    final String day = today.day.toString();
    return '$month/$day';
  }

  @override
  bool validateArgs(List<String>? args) {
    if (!super.validateArgs(args)) return false;
    // Args are null checked in super
    if (args!.length > 1) return false;
    if (!args.first.contains('/')) return false;
    final List<String> dateNums = args.first.split('/');
    if (dateNums.length != 2) return false;
    if (dateNums.any((String n) => n.length > 2)) {
      return false;
    }
    final int? month = int.tryParse(dateNums.first);
    final int? day = int.tryParse(dateNums.last);

    if (month == null || day == null) return false;
    return verifyMonthAndDate(month: month, day: day);
  }

  @override
  Stream<String> run({List<String>? args}) async* {
    String month = '';
    String day = '';
    String date = argDefault;

    // If the user specified a date, use it.
    if (args != null && args.isNotEmpty) {
      if (validateArgs(args)) {
        date = args.first.split('=').last;
      } else {
        yield Outputs.invalidArgs(this);
        return;
      }
    }

    [month, day] = date.split('/');

    try {
      final OnThisDayTimeline timeline =
          await WikipediaApiClient.getTimelineForDate(
            month: int.parse(month),
            day: int.parse(day),
            type: EventType.selected,
          );

      int i = 0;
      while (i < timeline.length) {
        assert(
          i >= 0 && i < timeline.length,
          'This method increments and decrements `i`, but i should always be '
          'a valid index of timeline ,',
        );
        yield _renderEvent(timeline, i);

        // Handle next action
        final ConsoleControl key = await console.readKey();
        switch (key) {
          case ConsoleControl.cursorUp:
          case ConsoleControl.cursorLeft:
            if (i == 0) {
              yield Outputs.onFirstEvent;
              await 700.ms();
              // wrap to last event
              i = timeline.length - 1;
            } else {
              i--;
            }
          case ConsoleControl.cursorDown:
          case ConsoleControl.cursorRight:
            if (i == timeline.length - 1) {
              yield Outputs.endOfList;
              await 700.ms();
              i = 0;
            } else {
              i++;
            }
          case ConsoleControl.q:
            return;
          case ConsoleControl.resetCursorPosition:
          case ConsoleControl.eraseLine:
          case ConsoleControl.eraseDisplay:
          case ConsoleControl.r:
          case ConsoleControl.unknown:
            console.eraseDisplay();
            console.resetCursorPosition();
            yield Outputs.unknownInput;
            yield Outputs.enterLeftOrRight;
        }
      }
    } finally {
      // "return to the menu" (print usage again)
      console
        ..eraseDisplay()
        ..resetCursorPosition()
        ..rawMode = false;
      await runner.onInput('help');
    }
  }

  String _renderEvent(OnThisDayTimeline timeline, int index) {
    console
      ..eraseDisplay()
      ..resetCursorPosition();
    return <String>[
      Outputs.event(timeline[index]),
      Outputs.eventNumber(index, timeline.length),
      Outputs.enterLeftOrRight,
    ].join('\n');
  }
}
