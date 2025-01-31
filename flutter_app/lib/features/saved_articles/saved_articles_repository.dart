import 'dart:async';

import 'package:wikipedia_api/wikipedia_api.dart';

class SavedArticlesRepository {
  SavedArticlesRepository() {
    _streamController.add(_cachedSavedArticles.values.toList());
  }

  final Map<String, Summary> _cachedSavedArticles = {};

  // This repository needs to stream data because multiple
  // viewModels need to be updated when an article is saved
  final StreamController<List<Summary>> _streamController =
      StreamController.broadcast();
  Stream<List<Summary>> get savedArticles => _streamController.stream;

  void saveArticle(Summary summary) {
    _cachedSavedArticles[summary.titles.canonical] = summary;
    _streamController.add(_cachedSavedArticles.values.toList());
  }

  void removeArticle(Summary summary) {
    _cachedSavedArticles.removeWhere(
      (key, _) => key == summary.titles.canonical,
    );
    _streamController.add(_cachedSavedArticles.values.toList());
  }
}
