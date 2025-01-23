import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelineViewModel<OnThisDayState> extends ChangeNotifier {
  TimelineViewModel() {
    getTimelineForDay(_date.month, _date.day);
  }

  List<OnThisDayEvent> _filteredEvents = [];
  UnmodifiableListView<OnThisDayEvent> get filteredEvents =>
      UnmodifiableListView(_filteredEvents);

  final DateTime _date = DateTime.now();

  late OnThisDayTimeline _timeline;

  String? error;

  bool get hasData => _filteredEvents.isNotEmpty;

  bool get hasError => error != null;

  // Be default, only show 'selected' events
  ValueNotifier<Map<EventType, bool>> selectEventTypes = ValueNotifier({
    EventType.holiday: false,
    EventType.birthday: false,
    EventType.death: false,
    EventType.selected: true,
    EventType.event: true,
  });

  void toggleSelectedType(EventType t, bool value) {
    selectEventTypes.value[t] = value;
    notifyListeners();
  }

  /// Returns the date with the format 'Month DD'
  String get readableDate {
    return _date.humanReadable;
  }

  String get readableYearRange {
    if (filteredEvents.every((e) => e.type == EventType.holiday)) return '';

    final start =
        filteredEvents.lastWhere((e) => e.type != EventType.holiday).year!;
    final end =
        filteredEvents.firstWhere((e) => e.type != EventType.holiday).year!;

    return '${start.absYear}-${end.absYear}';
  }

  void filterEvents() {
    var selectedTypes = selectEventTypes.value;
    _filteredEvents =
        _timeline.all.where((event) {
          return selectedTypes[event.type]!;
        }).toList();

    _filteredEvents.sort((eventA, eventB) {
      // Sorts all holidays to the end
      if (eventA.type == EventType.holiday) return -1;
      if (eventB.type == EventType.holiday) return 1;
      return eventB.year!.compareTo(eventA.year!);
    });

    notifyListeners();
  }

  Future<void> getTimelineForDay(int month, int day) async {
    try {
      _timeline = await WikipediaApiClient.getTimelineForDate(
        month: month,
        day: day,
      );

      filterEvents();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      error = 'failed to fetch timeline data';
      notifyListeners();
    }
  }
}
