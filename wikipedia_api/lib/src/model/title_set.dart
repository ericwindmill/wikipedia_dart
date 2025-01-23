import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TitlesSet {
  /// Returns a new [TitlesSet] instance.
  TitlesSet({
    required this.canonical,
    required this.normalized,
    required this.display,
  });

  /// the DB key (non-prefixed), e.g. may have _ instead of spaces,
  /// best for making request URIs, still requires Percent-encoding
  String canonical;

  /// the normalized title (https://www.mediawiki.org/wiki/API:Query#Example_2:_Title_normalization),
  /// e.g. may have spaces instead of _
  String normalized;

  /// the title as it should be displayed to the user
  String display;

  Map<String, dynamic> toJson() {
    return {
      'canonical': canonical,
      'normalized': normalized,
      'display': display,
    };
  }

  /// Returns a new [TitlesSet] instance and imports its values from a JSON map
  static TitlesSet fromJson(Map<String, Object?> json) {
    if (json case {
      'canonical': String canonical,
      'normalized': String normalized,
      'display': String display,
    }) {
      return TitlesSet(
        canonical: canonical,
        normalized: normalized,
        display: display,
      );
    }
    throw FormatException('Could not deserialize TitleSet, json=$json');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TitlesSet &&
          runtimeType == other.runtimeType &&
          canonical == other.canonical &&
          normalized == other.normalized &&
          display == other.display;

  @override
  int get hashCode =>
      canonical.hashCode ^ normalized.hashCode ^ display.hashCode;

  @override
  String toString() =>
      'TitlesSet[canonical=$canonical, normalized=$normalized, display=$display]';
}
