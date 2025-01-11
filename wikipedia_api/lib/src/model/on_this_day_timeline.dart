import 'dart:collection';

import 'on_this_day_inner.dart';

class OnThisDayTimeline extends IterableMixin<OnThisDayEvent> {
  /// Returns a new [OnThisDayTimeline] instance.
  OnThisDayTimeline({
    this.all = const [],
    this.births = const [],
    this.deaths = const [],
    this.events = const [],
    this.holidays = const [],
    this.selected = const [],
  });

  final List<OnThisDayEvent> all;

  final List<OnThisDayEvent> births;

  final List<OnThisDayEvent> deaths;

  final List<OnThisDayEvent> events;

  final List<OnThisDayEvent> holidays;

  final List<OnThisDayEvent> selected;

  @override
  Iterator<OnThisDayEvent> get iterator => all.iterator;

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
  /// TODO: Use JsonSerializable here, and then merge everything elsewhere
  static OnThisDayTimeline fromJson(Map<String, Object?> json) {
    if (json case {
      'births': List birthsJson,
      'deaths': List deathsJson,
      'events': List eventsJson,
      'holidays': List holidaysJson,
      'selected': List selectedJson,
    }) {
      var births = [for (var e in birthsJson) OnThisDayEvent.fromJson(e)];
      var deaths = [for (var e in deathsJson) OnThisDayEvent.fromJson(e)];
      var events = [for (var e in eventsJson) OnThisDayEvent.fromJson(e)];
      var holidays = [for (var e in holidaysJson) OnThisDayEvent.fromJson(e)];
      var selected = [for (var e in selectedJson) OnThisDayEvent.fromJson(e)];

      var all =
          {...births, ...deaths, ...events, ...holidays, ...selected}.toList();
      all.removeWhere((event) => event.year == null);
      all.sort((eventA, eventB) => eventA.year!.compareTo(eventB.year!));

      return OnThisDayTimeline(
        all: all,
        births: births,
        deaths: deaths,
        events: events,
        holidays: holidays,
        selected: selected,
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
