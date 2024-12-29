class Article {
  Article({required this.title, required this.extract});

  final String title;
  final String extract;

  static List<Article> listFromJson(Map<String, Object?> json) {
    print(json);
    final articles = <Article>[];
    if (json case {"query": {"pages": Map<String, Object?> pages}}) {
      for (var MapEntry(:key, :value) in pages.entries) {
        if (value case {"title": String title, "extract": String extract}) {
          articles.add(Article(title: title, extract: extract));
        }
      }
      return articles;
    }
    throw FormatException('Could not deserialize Article, json=$json');
  }

  Map<String, Object?> toJson() => {'title': title, 'extract': extract};

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
