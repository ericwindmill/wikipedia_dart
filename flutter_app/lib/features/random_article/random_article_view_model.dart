import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class RandomArticleViewModel extends ChangeNotifier {
  RandomArticleViewModel() {
    getRandomArticle();
  }

  late Summary articleSummary;
  bool hasData = false;
  String error = '';
  bool get hasError => error != '';

  Future<void> getRandomArticle() async {
    try {
      articleSummary = await WikipediaApiClient.getRandomArticle();
      hasData = true;
      notifyListeners();
    } on HttpException catch (e) {
      // TODO - handle exception gracefully
      print(e);
      hasData = false;
      error = e.message;
    } catch (e) {
      hasData = false;
      print('unknown error $e');
      error = e.toString();
    }
  }
}
