import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_repository.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

enum ElementType { heading1, heading2, heading3, paragraph, image }

typedef ArticleElement = ({String body, ElementType type});

class ArticleViewModel extends ChangeNotifier {
  ArticleViewModel(this.summary) {
    getFullArticle(summary.titles.canonical);
  }

  final ArticleRepository _repository = ArticleRepository();

  final Summary summary;

  Article? _article;

  bool get hasData => _article != null;

  String error = '';

  bool get hasError => error != '';

  List<ArticleElement> get article {
    if (!hasData) return [];

    final List<ArticleElement> elements = [];

    final List<String>? lines = _article?.extract.split('\n');
    for (final String line in lines!) {
      final String trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      if (trimmed.startsWith('====')) {
        final heading3 = trimmed.split('====')[1].trim();
        elements.add((body: heading3, type: ElementType.heading3));
      } else if (trimmed.startsWith('===')) {
        final heading2 = trimmed.split('===')[1].trim();
        elements.add((body: heading2, type: ElementType.heading2));
      } else if (trimmed.startsWith('==')) {
        final String heading = trimmed.split('==')[1].trim();
        elements.add((body: heading, type: ElementType.heading1));
      } else {
        elements.add((body: trimmed, type: ElementType.paragraph));
      }
    }

    return elements;
  }

  Future<void> getFullArticle(String canonicalTitle) async {
    try {
      final Article? article = await _repository.getArticleByTitle(
        canonicalTitle,
      );
      if (article != null) {
        _article = article;
      } else {
        error = 'Failed to fetch article. Please try again';
      }

      notifyListeners();
    } on HttpException catch (e) {
      error = e.message;
    }
  }
}
