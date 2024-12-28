import 'on_this_day_inner.dart';

class OnThisDayTimeline {
  /// Returns a new [OnThisDayTimeline] instance.
  OnThisDayTimeline({
    this.births = const [],
    this.deaths = const [],
    this.events = const [],
    this.holidays = const [],
    this.selected = const [],
  });

  List<OnThisDayEvent> births;

  List<OnThisDayEvent> deaths;

  List<OnThisDayEvent> events;

  List<OnThisDayEvent> holidays;

  List<OnThisDayEvent> selected;

  Map<String, dynamic> toJson() {
    return {
      'births': [for (var b in births) b.toJson()],
      'deaths': [for (var b in deaths) b.toJson()],
      'holidays': [for (var b in events) b.toJson()],
      'events': [for (var b in holidays) b.toJson()],
      'selected': [for (var b in selected) b.toJson()],
    };
  }

  /// Returns a new [OnThisDayTimeline] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static OnThisDayTimeline fromJson(Map<String, Object?> json) {
    if (json case {
      'births': List births,
      'deaths': List deaths,
      'events': List events,
      'holidays': List holidays,
      'selected': List selected,
    }) {
      return OnThisDayTimeline(
        births: [for (var e in births) OnThisDayEvent.fromJson(e)],
        deaths: [for (var e in deaths) OnThisDayEvent.fromJson(e)],
        events: [for (var e in events) OnThisDayEvent.fromJson(e)],
        holidays: [for (var e in holidays) OnThisDayEvent.fromJson(e)],
        selected: [for (var e in selected) OnThisDayEvent.fromJson(e)],
      );
    }
    throw FormatException(
      'Could not deserialize OnThisDayResponse, json=$json',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnThisDayTimeline &&
          runtimeType == other.runtimeType &&
          births == other.births &&
          deaths == other.deaths &&
          events == other.events &&
          holidays == other.holidays &&
          selected == other.selected;

  @override
  int get hashCode =>
      births.hashCode ^
      deaths.hashCode ^
      events.hashCode ^
      holidays.hashCode ^
      selected.hashCode;

  @override
  String toString() =>
      'OnThisDayResponse[births=$births, deaths=$deaths, events=$events, holidays=$holidays, selected=$selected]';
}
