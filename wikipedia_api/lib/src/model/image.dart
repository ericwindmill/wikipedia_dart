import 'package:wikipedia_api/src/model/original_image.dart';
import 'package:wikipedia_api/src/model/thumbnail.dart';

/// Contains images of different sizes and metadata
class WikipediaImage {
  final String title;
  final String artist;
  final String description;
  final String caption;
  final OriginalImage simpleImage;
  final Thumbnail thumbnail;

  WikipediaImage({
    required this.title,
    required this.artist,
    required this.description,
    required this.caption,
    required this.simpleImage,
    required this.thumbnail,
  });

  static WikipediaImage fromJson(Map<String, Object?> json) {
    if (json case {
      'title': String title,
      'thumbnail': Map<String, Object?> thumbnail,
      'image': Map<String, Object?> originalImage,
      'artist': {'text': String artistName},
      'description': {'text': String description},
      'structured': {'captions': {'en': String caption}},
    }) {
      return WikipediaImage(
        title: title,
        artist: artistName,
        description: description,
        caption: caption,
        simpleImage: OriginalImage.fromJson(originalImage),
        thumbnail: Thumbnail.fromJson(thumbnail),
      );
    }

    throw FormatException('Could not deserialize Image, json=$json');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WikipediaImage &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          artist == other.artist &&
          description == other.description &&
          caption == other.caption &&
          simpleImage == other.simpleImage &&
          thumbnail == other.thumbnail;

  @override
  int get hashCode =>
      title.hashCode ^
      artist.hashCode ^
      description.hashCode ^
      caption.hashCode ^
      simpleImage.hashCode ^
      thumbnail.hashCode;
}
