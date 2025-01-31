import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/util.dart';
import 'package:http/http.dart' as http;
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticleRepository {
  final Map<String, Article> _cachedArticles = {};

  Future<Article?> getArticleByTitle(String canonicalTitle) async {
    if (_cachedArticles.containsKey(canonicalTitle)) {
      return _cachedArticles[canonicalTitle]!;
    }

    final http.Client client = http.Client();
    try {
      final Uri url = Uri.http(serverUri, '/article/$canonicalTitle');
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final Map<String, Object?> jsonData =
            jsonDecode(response.body) as Map<String, Object?>;
        final article = Article.listFromJson(jsonData).first;
        _cachedArticles[canonicalTitle] = article;
        return article;
      }

      // TODO(ewindmill): handle failures correctly
    } on HttpException {
      rethrow;
    } on FormatException {
      rethrow;
    } finally {
      client.close();
    }
    return null;
  }
}
