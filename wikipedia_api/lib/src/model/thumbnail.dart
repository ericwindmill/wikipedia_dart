import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Thumbnail {
  /// Returns a new [Thumbnail] instance.
  Thumbnail({
    required this.source,
    required this.width,
    required this.height,
  });

  /// Thumbnail image URI
  String source;

  /// Thumbnail width
  int width;

  /// Thumbnail height
  int height;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'source': source,
      'width': width,
      'height': height,
    };
  }

  /// Returns a new [Thumbnail] instance
  static Thumbnail fromJson(Map<String, Object?> json) {
    if (json case {
      'source': final String source,
      'height': final int height,
      'width': final int width,
    }) {
      return Thumbnail(
        source: source,
        width: width,
        height: height,
      );
    }
    throw FormatException(
      'Could not deserialize Thumbnail, json=$json',
    );
  }

  @override
  String toString() =>
      'Thumbnail[source=$source, width=$width, height=$height]';
}
