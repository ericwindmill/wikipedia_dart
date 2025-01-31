import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_repository.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class SavedArticlesViewModel extends ChangeNotifier {
  SavedArticlesViewModel({required SavedArticlesRepository repository})
    : _repository = repository {
    _repository.savedArticles.listen((List<Summary> savedArticles) {
      _savedArticles = savedArticles;
      notifyListeners();
    });
  }

  final SavedArticlesRepository _repository;
  List<Summary> _savedArticles = [];

  UnmodifiableListView<Summary> get savedArticles =>
      UnmodifiableListView(_savedArticles);

  void saveArticle(Summary summary) {
    _repository.saveArticle(summary);
    notifyListeners();
  }

  void removeArticle(Summary summary) {
    _repository.removeArticle(summary);
    notifyListeners();
  }

  bool articleIsSaved(Summary summary) {
    return _savedArticles.any(
      (s) => s.titles.canonical == summary.titles.canonical,
    );
  }
}
