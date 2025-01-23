import 'package:json_annotation/json_annotation.dart';

/// Simple image is like a [Thumbnail], but full size
/// It doesn't contain any metadata from Wikipedia.
///
/// For images with metadata, see [Image]
@JsonSerializable()
class OriginalImage {
  /// Returns a new [OriginalImage] instance.
  OriginalImage({
    required this.source,
    required this.width,
    required this.height,
  });

  /// Original image URI
  String source;

  /// Original image width
  int width;

  /// Original image height
  int height;

  Map<String, Object?> toJson() {
    return {'source': source, 'width': width, 'height': height};
  }

  /// Returns a new [Thumbnail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static OriginalImage fromJson(Map<String, Object?> json) {
    if (json case {
      'source': String source,
      'height': int height,
      'width': int width,
    }) {
      return OriginalImage(source: source, width: width, height: height);
    }
    throw FormatException('Could not deserialize OriginalImage, json=$json');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OriginalImage &&
          runtimeType == other.runtimeType &&
          source == other.source &&
          width == other.width &&
          height == other.height;

  @override
  int get hashCode => source.hashCode ^ width.hashCode ^ height.hashCode;

  @override
  String toString() =>
      'OriginalImage[source_=$source, width=$width, height=$height]';
}
