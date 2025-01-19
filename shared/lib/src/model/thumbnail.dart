import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Thumbnail {
  /// Returns a new [Thumbnail] instance.
  Thumbnail({required this.source, required this.width, required this.height});

  /// Thumbnail image URI
  String source;

  /// Thumbnail width
  int width;

  /// Thumbnail height
  int height;

  Map<String, Object?> toJson() {
    return {'source': source, 'width': width, 'height': height};
  }

  /// Returns a new [Thumbnail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  static Thumbnail fromJson(Map<String, Object?> json) {
    if (json case {
      'source': String source,
      'height': int height,
      'width': int width,
    }) {
      return Thumbnail(source: source, width: width, height: height);
    }
    throw FormatException('Could not deserialize Thumbnail, json=$json');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Thumbnail &&
          runtimeType == other.runtimeType &&
          source == other.source &&
          width == other.width &&
          height == other.height;

  @override
  int get hashCode => source.hashCode ^ width.hashCode ^ height.hashCode;

  @override
  String toString() =>
      'Thumbnail[source=$source, width=$width, height=$height]';
}
