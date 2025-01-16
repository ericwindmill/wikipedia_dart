import '../../wikipedia_api.dart';
import 'event_type.dart';

class OnThisDayEvent {
  /// Returns a new [OnThisDayEvent] instance.
  OnThisDayEvent({
    required this.text,
    this.pages = const [],
    this.year,
    required this.type,
  });

  /// Short description of the event
  String text;

  /// List of pages related to the event
  List<Summary> pages;

  /// Year of the event
  final int? year;

  /// Selected: a list of a few selected anniversaries which occur on the provided day and month; often the entries are curated for the current year
  /// Births: a list of birthdays which happened on the provided day and month
  /// Deaths: a list of deaths which happened on the provided day and month
  /// Holidays: a list of fixed holidays celebrated on the provided day and month
  /// Events: a list of significant events which happened on the provided day and month and which are not covered by the other types yet
  final EventType type;

  /// Returns -1 if [year] is null
  int get yearsAgo => year != null ? DateTime.now().year - year! : -1;

  Map<String, Object?> toJson() {
    return {
      'text': text,
      'year': year,
      'pages': {for (var p in pages) p.toJson()},
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnThisDayEvent &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          type != type;

  @override
  int get hashCode => text.hashCode ^ pages.hashCode;

  @override
  String toString() => 'OnThisDayInner[text=$text, type=${type.name}]';

  static OnThisDayEvent fromJson(Map<String, Object?> json, EventType t) {
    return switch (json) {
      {'text': String text, 'year': int year, 'pages': Iterable pages} =>
        OnThisDayEvent(
          text: text,
          year: year,
          pages: [for (var p in pages) Summary.fromJson(p)],
          type: t,
        ),
      // holidays don't have years
      {'text': String text, 'pages': Iterable pages} => OnThisDayEvent(
        text: text,
        pages: [for (var p in pages) Summary.fromJson(p)],
        type: t,
      ),
      _ => throw FormatException('Invalid json in OnThisDayEvent.fromJson'),
    };
  }

  static OnThisDayEvent notableDeathFromJson(Map<String, Object?> json) {
    if (json case {
      'text': String text,
      'year': int year,
      'pages': Iterable pages,
    }) {
      return OnThisDayEvent(
        text: text,
        year: year,
        pages: [for (var p in pages) Summary.fromJson(p)],
        type: EventType.death,
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }

  /// Holidays don't have years
  static OnThisDayEvent holidayFromJson(Map<String, Object?> json) {
    if (json case {'text': String text, 'pages': Iterable pages}) {
      return OnThisDayEvent(
        text: text,
        pages: [for (var p in pages) Summary.fromJson(p)],
        type: EventType.holiday,
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }

  static OnThisDayEvent selectedEventFromJson(Map<String, Object?> json) {
    if (json case {
      'text': String text,
      'year': int year,
      'pages': Iterable pages,
    }) {
      return OnThisDayEvent(
        text: text,
        year: year,
        pages: [for (var p in pages) Summary.fromJson(p)],
        type: EventType.selected,
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }

  static OnThisDayEvent eventFromJson(Map<String, Object?> json) {
    if (json case {
      'text': String text,
      'year': int year,
      'pages': Iterable pages,
    }) {
      return OnThisDayEvent(
        text: text,
        year: year,
        pages: [for (var p in pages) Summary.fromJson(p)],
        type: EventType.event,
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }
}
