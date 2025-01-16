import '../../wikipedia_api.dart';

class Summary {
  /// Returns a new [Summary] instance.
  Summary({
    required this.titles,
    required this.pageid,
    required this.extract,
    required this.extractHtml,
    this.thumbnail,
    this.originalImage,
    this.url,
    required this.lang,
    required this.dir,
    this.description,
  });

  ///
  TitlesSet titles;

  /// The page ID
  int pageid;

  /// First several sentences of an article in plain text
  String extract;

  /// First several sentences of an article in simple HTML format
  String extractHtml;

  Thumbnail? thumbnail;

  /// Url to the article on Wikipedia
  String? url;

  ///
  OriginalImage? originalImage;

  /// The page language code
  String lang;

  /// The page language direction code
  String dir;

  /// Wikidata description for the page
  String? description;

  Map<String, dynamic> toJson() {
    return {};
  }

  /// Returns a new [Summary] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Summary fromJson(Map<String, Object?> json) {
    return switch (json) {
      {
        'titles': Map<String, Object?> titles,
        'pageid': int pageid,
        'extract': String extract,
        'extract_html': String extractHtml,
        'lang': String lang,
        'dir': String dir,
        'content_urls': {
          'desktop': {'page': String url},
          'mobile': {'page': String _},
        },
        'description': String description,
        'thumbnail': Map<String, Object?> thumbnail,
        'originalimage': Map<String, Object?> originalImage,
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageid: pageid,
          extract: extract,
          extractHtml: extractHtml,
          thumbnail: Thumbnail.fromJson(thumbnail),
          originalImage: OriginalImage.fromJson(originalImage),
          lang: lang,
          dir: dir,
          url: url,
          description: description,
        ),
      {
        'titles': Map<String, Object?> titles,
        'pageid': int pageid,
        'extract': String extract,
        'extract_html': String extractHtml,
        'lang': String lang,
        'dir': String dir,
        'thumbnail': Map<String, Object?> thumbnail,
        'originalimage': Map<String, Object?> originalImage,
        'content_urls': {
          'desktop': {'page': String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageid: pageid,
          extract: extract,
          extractHtml: extractHtml,
          thumbnail: Thumbnail.fromJson(thumbnail),
          originalImage: OriginalImage.fromJson(originalImage),
          lang: lang,
          dir: dir,
          url: url,
        ),
      {
        'titles': Map<String, Object?> titles,
        'pageid': int pageid,
        'extract': String extract,
        'extract_html': String extractHtml,
        'lang': String lang,
        'dir': String dir,
        'description': String description,
        'content_urls': {
          'desktop': {'page': String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageid: pageid,
          extract: extract,
          extractHtml: extractHtml,
          lang: lang,
          dir: dir,
          description: description,
          url: url,
        ),
      {
        'titles': Map<String, Object?> titles,
        'pageid': int pageid,
        'extract': String extract,
        'extract_html': String extractHtml,
        'lang': String lang,
        'dir': String dir,
        'content_urls': {
          'desktop': {'page': String url},
          'mobile': {'page': String _},
        },
      } =>
        Summary(
          titles: TitlesSet.fromJson(titles),
          pageid: pageid,
          extract: extract,
          extractHtml: extractHtml,
          lang: lang,
          dir: dir,
          url: url,
        ),
      _ => throw FormatException('Could not deserialize Summary, json=$json'),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Summary &&
          runtimeType == other.runtimeType &&
          titles == other.titles &&
          pageid == other.pageid &&
          extract == other.extract &&
          extractHtml == other.extractHtml &&
          thumbnail == other.thumbnail &&
          originalImage == other.originalImage &&
          lang == other.lang &&
          dir == other.dir &&
          description == other.description;

  @override
  int get hashCode =>
      titles.hashCode ^
      pageid.hashCode ^
      extract.hashCode ^
      extractHtml.hashCode ^
      thumbnail.hashCode ^
      originalImage.hashCode ^
      lang.hashCode ^
      dir.hashCode ^
      description.hashCode;

  @override
  String toString() =>
      'Summary[titles=$titles, pageid=$pageid, extract=$extract, extractHtml=$extractHtml, thumbnail=${thumbnail ?? 'null'}, originalImage=${originalImage ?? 'null'}, lang=$lang, dir=$dir, description=$description]';
}
