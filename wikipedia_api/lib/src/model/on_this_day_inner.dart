import '../../wikipedia_api.dart';

class OnThisDayEvent {
  /// Returns a new [OnThisDayEvent] instance.
  OnThisDayEvent({required this.text, this.year, this.pages = const []});

  // Description of the event
  String text;

  // Year of the event
  int? year;

  /// List of pages related to the event
  List<Summary> pages;

  Map<String, Object?> toJson() {
    return {
      'text': text,
      'year': year,
      'pages': {for (var p in pages) p.toJson()},
    };
  }

  static OnThisDayEvent fromJson(Map<String, Object?> json) {
    return switch (json) {
      {'text': String text, 'year': int year, 'pages': Iterable pages} =>
        OnThisDayEvent(
          text: text,
          year: year,
          pages: [for (var p in pages) Summary.fromJson(p)],
        ),
      {'text': String text, 'pages': Iterable pages} => Holiday(
        text: text,
        pages: [for (var p in pages) Summary.fromJson(p)],
      ),
      _ =>
        throw FormatException(
          'Could not deserialize OnThisDayInner, json=$json',
        ),
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

class Holiday extends OnThisDayEvent {
  Holiday({required super.text, super.pages});
}
