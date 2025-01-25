import 'package:wikipedia_api/src/model/original_image.dart';
import 'package:wikipedia_api/src/model/thumbnail.dart';

/// Contains images of different sizes and metadata
class WikipediaImage {
  final String title;
  final OriginalImage originalImage;
  final String? artist;
  final String? description;
  final String? caption;
  final Thumbnail? thumbnail;

  WikipediaImage({
    required this.title,
    required this.originalImage,
    this.artist,
    this.description,
    this.caption,

    this.thumbnail,
  });

  static WikipediaImage fromJson(Map<String, Object?> json) {
    return switch (json) {
      {
        'title': String title,
        'thumbnail': Map<String, Object?> thumbnail,
        'image': Map<String, Object?> originalImage,
        'artist': {'text': String artistName},
        'description': {'text': String description},
        'structured': {'captions': {'en': String caption}},
      } =>
        WikipediaImage(
          title: title,
          artist: artistName,
          description: description,
          caption: caption,
          originalImage: OriginalImage.fromJson(originalImage),
          thumbnail: Thumbnail.fromJson(thumbnail),
        ),
      {
        'title': String title,
        'thumbnail': Map<String, Object?> thumbnail,
        'image': Map<String, Object?> originalImage,
        'artist': {'text': String artistName},
        'description': {'text': String description},
      } =>
        WikipediaImage(
          title: title,
          artist: artistName,
          description: description,
          originalImage: OriginalImage.fromJson(originalImage),
          thumbnail: Thumbnail.fromJson(thumbnail),
        ),
      // minimum required image properties
      {'title': String title, 'image': Map<String, Object?> originalImage} =>
        WikipediaImage(
          title: title,
          originalImage: OriginalImage.fromJson(originalImage),
        ),
      _ => throw FormatException('Could not deserialize Image, json=$json'),
    };
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
          originalImage == other.originalImage &&
          thumbnail == other.thumbnail;

  @override
  int get hashCode =>
      title.hashCode ^
      artist.hashCode ^
      description.hashCode ^
      caption.hashCode ^
      originalImage.hashCode ^
      thumbnail.hashCode;
}
