import 'package:json_annotation/json_annotation.dart';
import 'package:wikipedia_api/src/model/image.dart';
import 'package:wikipedia_api/src/model/thumbnail.dart' show Thumbnail;
import 'package:wikipedia_api/wikipedia_api.dart' show Thumbnail;

/// Simple image is like a [Thumbnail], but full size
/// It doesn't contain any metadata from Wikipedia.
///
/// For images with metadata, see [WikipediaImage]
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
    return <String, Object?>{
      'source': source,
      'width': width,
      'height': height,
    };
  }

  /// Returns a new [Thumbnail] instance
  // ignore: prefer_constructors_over_static_methods
  static OriginalImage fromJson(Map<String, Object?> json) {
    if (json case {
      'source': final String source,
      'height': final int height,
      'width': final int width,
    }) {
      return OriginalImage(source: source, width: width, height: height);
    }
    throw FormatException('Could not deserialize OriginalImage, json=$json');
  }

  @override
  String toString() =>
      'OriginalImage[source_=$source, width=$width, height=$height]';
}
