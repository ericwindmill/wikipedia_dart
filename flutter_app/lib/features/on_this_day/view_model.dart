import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shared/wikipedia_api.dart';

class OnThisDayViewModel extends ChangeNotifier {
  OnThisDayViewModel({DateTime? date}) {
    _date = date ?? DateTime.now();
    getTimelineForDay(_date!.month, _date!.day);
  }

  List<OnThisDayEvent> _filteredEvents = [];
  UnmodifiableListView<OnThisDayEvent> get filteredEvents =>
      UnmodifiableListView(_filteredEvents);

  String? error;

  late OnThisDayTimeline _timeline;
  DateTime? _date;

  bool get hasData => _filteredEvents.isNotEmpty;
  bool get hasError => error != null;

  final ScrollController _controller = ScrollController();
  get scrollController => _controller;
  get coords {
    _controller.position;
  }

  /// Be default, all events with dates are selected
  ValueNotifier<Map<EventType, bool>> selectEventTypes = ValueNotifier({
    EventType.holiday: false,
    EventType.birthday: true,
    EventType.death: false,
    EventType.selected: true,
    EventType.event: true,
  });

  void toggleSelectedType(EventType t, bool value) {
    selectEventTypes.value[t] = value;
    notifyListeners();
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

  /// Returns the date with the format Month DD
  String get readableDate {
    if (_date == null) return '';
    return _date!.humanReadable;
  }

  String get readableYearRange {
    if (_filteredEvents.every((e) => e.type == EventType.holiday)) return '';

    final start =
        _filteredEvents.lastWhere((e) => e.type != EventType.holiday).year!;
    final end =
        _filteredEvents.firstWhere((e) => e.type != EventType.holiday).year!;

    return '${start.absYear}-${end.absYear}';
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
