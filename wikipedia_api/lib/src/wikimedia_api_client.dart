import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wikipedia_api/src/model/article.dart';
import 'package:wikipedia_api/src/model/search_results.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class WikimediaApiClient {
  static Future<List<Article>> getArticleByTitle(String title) async {
    final http.Client client = http.Client();
    try {
      final Uri url = Uri.https(
        'en.wikipedia.org',
        '/w/api.php',
        <String, Object?>{
          // order matters - explaintext must come after prop
          'action': 'query',
          'format': 'json',
          'titles': title.trim(),
          'prop': 'extracts',
          'explaintext': '',
        },
      );
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final Map<String, Object?> jsonData =
            jsonDecode(response.body) as Map<String, Object?>;
        return Article.listFromJson(jsonData);
      } else {
        throw HttpException(
          '[WikimediaApiClient.getArticleByTitle] '
          'statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on FormatException {
      rethrow;
    } finally {
      client.close();
    }
  }

  static Future<List<WikipediaImage>> getArticleImages(String title) async {
    final http.Client client = http.Client();
    try {
      final Uri url = Uri.https(
        'en.wikipedia.org',
        '/w/api.php',
        <String, Object?>{
          // order matters - explaintext must come after prop
          'action': 'query',
          'format': 'json',
          'titles': title.trim(),
          'prop': 'pageimages',
          'pilicense': 'any',
          'pilimit': 'max',
          'explaintext': '',
        },
      );
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final Map<String, Object?> jsonData =
            jsonDecode(response.body) as Map<String, Object?>;
        return WikipediaImage.listFromJson(jsonData);
      } else {
        throw HttpException(
          '[WikimediaApiClient.getArticleByTitle] '
          'statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on FormatException {
      rethrow;
    } finally {
      client.close();
    }
  }

  static Future<SearchResults> search(String searchTerm) async {
    final http.Client client = http.Client();
    try {
      final Uri url = Uri.https(
        'en.wikipedia.org',
        '/w/api.php',
        <String, Object?>{
          'action': 'opensearch',
          'format': 'json',
          'search': searchTerm,
        },
      );
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final List<Object?> jsonData =
            jsonDecode(response.body) as List<Object?>;
        return SearchResults.fromJson(jsonData);
      } else {
        throw HttpException(
          '[WikimediaApiClient.getArticleByTitle] '
          'statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception('Unexpected error - $error');
    } finally {
      client.close();
    }
  }
}
