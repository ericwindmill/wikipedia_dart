class Article {
  Article({required this.title, required this.extract});

  final String title;
  final String extract;

  static List<Article> listFromJson(
    Map<String, Object?> json,
  ) {
    final List<Article> articles = <Article>[];
    if (json case {
      'query': {'pages': final Map<String, Object?> pages},
    }) {
      for (final MapEntry(:Object? value)
          in pages.entries) {
        if (value case {
          'title': final String title,
          'extract': final String extract,
        }) {
          articles.add(
            Article(title: title, extract: extract),
          );
        }
      }
      return articles;
    }
    throw FormatException(
      'Could not deserialize Article, json=$json',
    );
  }

  Map<String, Object?> toJson() => <String, Object?>{
    'title': title,
    'extract': extract,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          extract == other.extract;

  @override
  int get hashCode => title.hashCode ^ extract.hashCode;

  @override
  String toString() {
    return 'Article{title: $title, extract: $extract}';
  }
}
