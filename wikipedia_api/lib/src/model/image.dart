import 'original_image.dart';
import 'thumbnail.dart';

/// Contains images of different sizes and metadata
class WikipediaImage {
  WikipediaImage({
    required this.title,
    required this.originalImage,
    this.artist,
    this.description,
    this.caption,

    this.thumbnail,
  });
  final String title;
  final OriginalImage originalImage;
  final String? artist;
  final String? description;
  final String? caption;
  final Thumbnail? thumbnail;

  static WikipediaImage fromJson(
    Map<String, Object?> json,
  ) {
    return switch (json) {
      {
        'title': final String title,
        'thumbnail': final Map<String, Object?> thumbnail,
        'image': final Map<String, Object?> originalImage,
        'artist': {'text': final String artistName},
        'description': {'text': final String description},
        'structured': {
          'captions': {'en': final String caption},
        },
      } =>
        WikipediaImage(
          title: title,
          artist: artistName,
          description: description,
          caption: caption,
          originalImage: OriginalImage.fromJson(
            originalImage,
          ),
          thumbnail: Thumbnail.fromJson(thumbnail),
        ),
      {
        'title': final String title,
        'thumbnail': final Map<String, Object?> thumbnail,
        'image': final Map<String, Object?> originalImage,
        'artist': {'text': final String artistName},
        'description': {'text': final String description},
      } =>
        WikipediaImage(
          title: title,
          artist: artistName,
          description: description,
          originalImage: OriginalImage.fromJson(
            originalImage,
          ),
          thumbnail: Thumbnail.fromJson(thumbnail),
        ),
      // minimum required image properties
      {
        'title': final String title,
        'image': final Map<String, Object?> originalImage,
      } =>
        WikipediaImage(
          title: title,
          originalImage: OriginalImage.fromJson(
            originalImage,
          ),
        ),
      _ =>
        throw FormatException(
          'Could not deserialize Image, json=$json',
        ),
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
