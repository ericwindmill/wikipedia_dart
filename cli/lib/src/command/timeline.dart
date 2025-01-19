part of 'command.dart';

enum _TimelineInputs {
  next(['next', 'n']),
  back(['back', 'b']);

  const _TimelineInputs(this.aliases);

  final List<String> aliases;
}

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
  Stream<String> run({List<String>? args}) async* {
    var month = '';
    var day = '';
    var date = argDefault;

    if (args != null && args.isNotEmpty) {
      date = args.first.split('=').last;
    } else if (args != null && args.length > 1) {
      yield 'Invalid args for command. Command takes 1 argument: date=MM/DD';
      return;
    }

    [month, day] = date.split('/');

    try {
      final timeline = await WikipediaApiClient.getTimelineForDate(
        month: int.parse(month),
        day: int.parse(day),
        type: EventType.selected,
      );

      var output = Outputs.event(timeline.first);
      yield output;
      var i = 1;
      while (i < timeline.length) {
        var next = await prompt(
          'enter n for next, and back to return to menu.',
        );
        if (_TimelineInputs.next.aliases.contains(next)) {
          var event = timeline[i];
          yield Outputs.event(event);
          i++;
        } else if (_TimelineInputs.back.aliases.contains(next)) {
          break;
        } else {
          yield 'Unknown input $next';
        }
      }

      runner.onInput('help');
    } catch (e) {
      yield e.toString();
      return;
    }

    yield 'End of event list.';
    return;
  }
}
