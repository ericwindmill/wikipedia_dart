import '../../wikipedia_api.dart';

sealed class OnThisDayEvent {
  /// Returns a new [OnThisDayEvent] instance.
  OnThisDayEvent({required this.text, this.pages = const []});

  // Description of the event
  String text;

  /// List of pages related to the event
  List<Summary> pages;

  static Map<String, Object?> toJson(OnThisDayEvent instance) {
    return switch (instance) {
      Year e => {
        'text': e.text,
        'year': e.year,
        'pages': {for (var p in e.pages) p.toJson()},
      },
      Holiday h => {
        'text': h.text,
        'pages': {for (var p in h.pages) p.toJson()},
      },
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnThisDayEvent &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          pages == other.pages;

  @override
  int get hashCode => text.hashCode ^ pages.hashCode;

  @override
  String toString() => 'OnThisDayInner[text=$text, pages=$pages]';
}

// Holidays don't have years
class Holiday extends OnThisDayEvent {
  Holiday({required super.text, super.pages});

  static Holiday fromJson(Map<String, Object?> json) {
    if (json case {'text': String text, 'pages': Iterable pages}) {
      return Holiday(
        text: text,
        pages: [for (var p in pages) Summary.fromJson(p)],
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }
}

mixin Year on OnThisDayEvent {
  // Year of the event
  late final int year;

  int get yearsAgo => DateTime.now().year - year;
}

class Birthday extends OnThisDayEvent with Year {
  Birthday({required super.text, super.pages, required this.year});

  @override
  final int year;

  static Birthday fromJson(Map<String, Object?> json) {
    if (json case {
      'text': String text,
      'year': int year,
      'pages': Iterable pages,
    }) {
      return Birthday(
        text: text,
        year: year,
        pages: [for (var p in pages) Summary.fromJson(p)],
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }
}

class NotableDeath extends OnThisDayEvent with Year {
  NotableDeath({required super.text, super.pages, required this.year});

  // Year of the event
  @override
  final int year;

  static NotableDeath fromJson(Map<String, Object?> json) {
    if (json case {
      'text': String text,
      'year': int year,
      'pages': Iterable pages,
    }) {
      return NotableDeath(
        text: text,
        year: year,
        pages: [for (var p in pages) Summary.fromJson(p)],
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }
}

class FeaturedEvent extends OnThisDayEvent with Year {
  FeaturedEvent({required super.text, super.pages, required this.year});

  // Year of the event
  @override
  final int year;

  static FeaturedEvent fromJson(Map<String, Object?> json) {
    if (json case {
      'text': String text,
      'year': int year,
      'pages': Iterable pages,
    }) {
      return FeaturedEvent(
        text: text,
        year: year,
        pages: [for (var p in pages) Summary.fromJson(p)],
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }
}

class Event extends OnThisDayEvent with Year {
  Event({required super.text, super.pages, required this.year});

  // Year of the event
  @override
  final int year;

  static Event fromJson(Map<String, Object?> json) {
    if (json case {
      'text': String text,
      'year': int year,
      'pages': Iterable pages,
    }) {
      return Event(
        text: text,
        year: year,
        pages: [for (var p in pages) Summary.fromJson(p)],
      );
    }

    throw FormatException('Invalid json in OnThisDayEvent.fromJson');
  }
}
