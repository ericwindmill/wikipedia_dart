import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

import 'package:wikipedia_api/src/model/event_type.dart';
import 'package:wikipedia_api/src/model/on_this_day_event.dart';

@JsonSerializable(explicitToJson: true)
class OnThisDayTimeline extends IterableMixin<OnThisDayEvent> {
  /// Returns a new [OnThisDayTimeline] instance.
  OnThisDayTimeline({
    this.all = const <OnThisDayEvent>[],
    this.births = const <OnThisDayEvent>[],
    this.deaths = const <OnThisDayEvent>[],
    this.events = const <OnThisDayEvent>[],
    this.holidays = const <OnThisDayEvent>[],
    this.selected = const <OnThisDayEvent>[],
  });

  final List<OnThisDayEvent> all;

  final List<OnThisDayEvent> births;

  final List<OnThisDayEvent> deaths;

  final List<OnThisDayEvent> events;

  final List<OnThisDayEvent> holidays;

  final List<OnThisDayEvent> selected;

  @override
  Iterator<OnThisDayEvent> get iterator => all.iterator;

  /// Returns a new [OnThisDayTimeline] instance
  static OnThisDayTimeline fromJson(Map<String, Object?> json) {
    final List<OnThisDayEvent> births =
        (json['births'] as List<Map<String, Object?>>?)
            ?.map(
              (Map<String, Object?> e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.birthday,
              ),
            )
            .toList() ??
        const <OnThisDayEvent>[];

    final List<OnThisDayEvent> deaths =
        (json['deaths'] as List<Map<String, Object?>>?)
            ?.map(
              (Map<String, Object?> e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.death,
              ),
            )
            .toList() ??
        const <OnThisDayEvent>[];

    final List<OnThisDayEvent> events =
        (json['events'] as List<Map<String, Object?>>?)
            ?.map(
              (Map<String, Object?> e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.event,
              ),
            )
            .toList() ??
        const <OnThisDayEvent>[];

    final List<OnThisDayEvent> holidays =
        (json['holidays'] as List<Map<String, Object?>>?)
            ?.map(
              (Map<String, Object?> e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.holiday,
              ),
            )
            .toList() ??
        const <OnThisDayEvent>[];

    final List<OnThisDayEvent> selected =
        (json['selected'] as List<Map<String, Object?>>?)
            ?.map(
              (Map<String, Object?> e) => OnThisDayEvent.fromJson(
                e as Map<String, dynamic>,
                EventType.selected,
              ),
            )
            .toList() ??
        const <OnThisDayEvent>[];

    final List<OnThisDayEvent> all = <OnThisDayEvent>[
      ...births,
      ...deaths,
      ...events,
      ...holidays,
      ...selected,
    ]..sort((OnThisDayEvent eventA, OnThisDayEvent eventB) {
      // Sorts all holidays to the end
      if (eventA.type == EventType.holiday) return -1;
      if (eventB.type == EventType.holiday) return 1;
      return eventB.year!.compareTo(eventA.year!);
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
  String toString() =>
      'OnThisDayResponse['
      'births=$births, '
      'deaths=$deaths, '
      'events=$events, '
      'holidays=$holidays, '
      'selected=$selected'
      ']';
}
