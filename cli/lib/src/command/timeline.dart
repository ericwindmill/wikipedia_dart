part of 'command.dart';

class TimelineCommand extends Command<String> with Args {
  @override
  String get name => 'timeline';

  @override
  List<String> get aliases => ['t'];

  @override
  String get description =>
      'Lists historic events that happened on the given date.';

  @override
  String get argHelp => 'MM/DD';

  @override
  String get argName => 'date';

  @override
  bool get required => false;

  @override
  String get argDefault {
    var today = DateTime.now();
    var month = today.month.toString();
    var day = today.day.toString();
    return '$month/$day';
  }

  @override
  bool validateArgs(List<String>? args) {
    if (!super.validateArgs(args)) return false;
    // Args are null checked in super
    if (args!.length > 1) return false;
    if (!args.first.contains('/')) return false;
    var dateNums = args.first.split('/');
    if (dateNums.length != 2) return false;
    if (dateNums.any((n) => n.length > 2)) return false;
    var month = int.tryParse(dateNums.first);
    var day = int.tryParse(dateNums.last);

    if (month == null || day == null) return false;
    return verifyMonthAndDate(month: month, day: day);
  }

  @override
  Stream<String> run({List<String>? args}) async* {
    var month = '';
    var day = '';
    var date = argDefault;

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
      final timeline = await WikipediaApiClient.getTimelineForDate(
        month: int.parse(month),
        day: int.parse(day),
        type: EventType.selected,
      );

      var i = 0;
      var event = timeline[i];
      console.eraseDisplay();
      console.resetCursorPosition();
      yield Outputs.event(event);
      yield Outputs.enterLeftOrRight;
      stdout.write(ConsoleControl.cursorUp.execute);
      while (i <= timeline.length) {
        var key = await console.readKey();
        switch (key) {
          case ConsoleControl.cursorUp:
          case ConsoleControl.cursorLeft:
            if (i <= 0) {
              i = 0;
              yield Outputs.onFirstEvent;
              continue;
            } else {
              i--;
              var event = timeline[i];
              // erases reminder text
              console.eraseDisplay();
              console.resetCursorPosition();
              yield Outputs.event(event);
              yield Outputs.enterLeftOrRight;
              stdout.write(ConsoleControl.cursorUp.execute);
            }
          case ConsoleControl.cursorDown:
          case ConsoleControl.cursorRight:
            // break at the end if the user tries to go next
            if (i == timeline.length) {
              i++;
              break;
            }
            var event = timeline[i];
            console.eraseDisplay();
            console.resetCursorPosition();
            yield Outputs.event(event);
            // until the last one
            if (i + 1 < timeline.length) {
              yield Outputs.enterLeftOrRight;
              stdout.write(ConsoleControl.cursorUp.execute);
            } else {
              // for last event
              yield Outputs.endOfList.red;
              yield 'q to return to menu.';
            }
            i++;
          case ConsoleControl.q:
            return;
          default:
            console.eraseLine();
            yield Outputs.unknownInput;
            yield Outputs.enterLeftOrRight;
        }
      }
    } catch (e) {
      yield e.toString();
      return;
    } finally {
      // "return to the menu" (print usage again)
      console.eraseDisplay();
      console.resetCursorPosition();
      runner.onInput('help');
    }
  }
}
