import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_repository.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class SavedArticlesViewModel extends ChangeNotifier {
  SavedArticlesViewModel({required SavedArticlesRepository repository})
    : _repository = repository {
    _repository.addListener(notifyListeners);
  }

  UnmodifiableMapView<String, Summary> get savedArticles =>
      UnmodifiableMapView(_repository.savedArticles.value);

  final SavedArticlesRepository _repository;

  void saveArticle(Summary summary) {
    _repository.saveArticle(summary);
    notifyListeners();
  }

  void removeArticle(Summary summary) {
    _repository.removeArticle(summary);
    notifyListeners();
  }

  bool articleIsSaved(Summary summary) {
    return savedArticles.values.any(
      (s) => s.titles.canonical == summary.titles.canonical,
    );
  }
}
