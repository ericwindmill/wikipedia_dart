import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

import 'event_type.dart';
import 'on_this_day_event.dart';

@JsonSerializable(explicitToJson: true)
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
  static OnThisDayTimeline fromJson(Map<String, Object?> json) {
    final List<OnThisDayEvent> births =
        (json['births'] as List<dynamic>?)
            ?.map(
              (e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.birthday,
              ),
            )
            .toList() ??
        const [];

    final List<OnThisDayEvent> deaths =
        (json['deaths'] as List<dynamic>?)
            ?.map(
              (e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.death,
              ),
            )
            .toList() ??
        const [];

    final List<OnThisDayEvent> events =
        (json['deaths'] as List<dynamic>?)
            ?.map(
              (e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.event,
              ),
            )
            .toList() ??
        const [];

    final List<OnThisDayEvent> holidays =
        (json['holidays'] as List<dynamic>?)
            ?.map(
              (e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.holiday,
              ),
            )
            .toList() ??
        const [];

    final List<OnThisDayEvent> selected =
        (json['selected'] as List<dynamic>?)
            ?.map(
              (e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.selected,
              ),
            )
            .toList() ??
        const [];

    List<OnThisDayEvent> all = [
      ...births,
      ...deaths,
      ...events,
      ...holidays,
      ...selected,
    ];

    all.sort((eventA, eventB) {
      // Sorts all holidays to the end
      if (eventA.type == EventType.holiday) return -1;
      if (eventB.type == EventType.holiday) return 1;
      return eventA.year!.compareTo(eventB.year!);
    });

    return OnThisDayTimeline(
      all: all,
      births: births,
      deaths: deaths,
      events: events,
      holidays: holidays,
      selected: selected,
    );
  }

  OnThisDayEvent operator [](int i) {
    return all[i];
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
