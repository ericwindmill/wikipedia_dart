import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wikipedia_api/src/model/search_results.dart';

import 'model/article.dart';

class WikimediaApiClient {
  static Future<List<Article>> getArticleByTitle(String title) async {
    final client = http.Client();
    try {
      final url = Uri.https('en.wikipedia.org', '/w/api.php', {
        // order matters - explaintext must come after prop
        'action': 'query',
        'format': 'json',
        'titles': title.trim(),
        'prop': 'extracts',
        'explaintext': '',
      });
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Article.listFromJson(jsonData);
      } else {
        throw HttpException(
          '[WikimediaApiClient.getArticleByTitle] statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception("Unexpected error - $error");
    } finally {
      client.close();
    }
  }

  static Future<SearchResults> search(String searchTerm) async {
    final client = http.Client();
    try {
      final url = Uri.https('en.wikipedia.org', '/w/api.php', {
        // order matters - explaintext must come after prop
        'action': 'opensearch',
        'format': 'json',
        'search': searchTerm,
      });
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return SearchResults.fromJson(jsonData);
      } else {
        throw HttpException(
          '[WikimediaApiClient.getArticleByTitle] statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception("Unexpected error - $error");
    } finally {
      client.close();
    }
  }
}
