import 'package:flutter/cupertino.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class SavedArticlesRepository {
  SavedArticlesRepository() {
    /// Seed the stream with an empty map
  }

  final Map<String, Summary> _cachedSavedArticles = {};

  ValueNotifier<Map<String, Summary>> get savedArticles =>
      ValueNotifier(_cachedSavedArticles);

  void saveArticle(Summary summary) {
    _cachedSavedArticles[summary.titles.canonical] = summary;
  }

  void removeArticle(Summary summary) {
    _cachedSavedArticles.removeWhere(
      (key, _) => key == summary.titles.canonical,
    );
  }
}
