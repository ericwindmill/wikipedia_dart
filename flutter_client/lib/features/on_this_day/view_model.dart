import 'package:flutter/cupertino.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class OnThisDayViewModel extends ChangeNotifier {
  OnThisDayViewModel() {
    var today = DateTime.now();
    getTimelineForDay(today.month, today.day);
  }

  List<OnThisDayEvent> events = [];
  bool get hasData => events.isNotEmpty;
  bool get hasError => error != null;
  String? error;

  Future<void> getTimelineForDay(int month, int day) async {
    try {
      var onThisDayTimeline = await WikipediaApiClient.getTimelineForDate(
        month: month,
        day: day,
      );

      events = onThisDayTimeline.all;
      notifyListeners();
    } catch (e) {
      print(e);
      error = 'failed to fetch timeline data';
      notifyListeners();
    }
  }
}
