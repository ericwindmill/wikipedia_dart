import 'package:flutter/cupertino.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class SavedArticlesRepository extends ChangeNotifier {
  SavedArticlesRepository();

  final Map<String, Summary> _cachedSavedArticles = {};

  ValueNotifier<Map<String, Summary>> get savedArticles =>
      ValueNotifier(_cachedSavedArticles);

  void saveArticle(Summary summary) {
    _cachedSavedArticles[summary.titles.canonical] = summary;
    notifyListeners();
  }

  void removeArticle(Summary summary) {
    _cachedSavedArticles.removeWhere(
      (key, _) => key == summary.titles.canonical,
    );
    notifyListeners();
  }
}
