import 'package:flutter/cupertino.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class OnThisDayViewModel extends ChangeNotifier {
  OnThisDayViewModel({DateTime? date}) {
    _date = date ?? DateTime.now();
    getTimelineForDay(_date!.month, _date!.day);
  }

  List<OnThisDayEvent> events = [];
  bool get hasData => events.isNotEmpty;
  bool get hasError => error != null;
  String? error;
  DateTime? _date;

  String get readableDate {
    if (_date == null) return '';
    return _date!.humanReadable;
  }

  String get readableYearRange {
    final start = events.lastWhere((e) => e is! Holiday);
    final end = events.firstWhere((e) => e is! Holiday);
    var str = StringBuffer();
    str.write(start.year.abs().toString());

    if (start < 0) {
      str.write(' BCE');
    }

    str.write('-${end.abs()}');

    return str.toString();
  }

  Future<void> getTimelineForDay(int month, int day) async {
    try {
      var onThisDayTimeline = await WikipediaApiClient.getTimelineForDate(
        month: month,
        day: day,
      );

      events = onThisDayTimeline.all.reversed.toList();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      error = 'failed to fetch timeline data';
      notifyListeners();
    }
  }
}
