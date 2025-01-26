import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'model/article.dart';
import 'model/search_results.dart';

class WikimediaApiClient {
  static Future<List<Article>> getArticleByTitle(
    String title,
  ) async {
    final http.Client client = http.Client();
    try {
      final Uri
      url = Uri.https('en.wikipedia.org', '/w/api.php', <
        String,
        Object?
      >{
        // order matters - explaintext must come after prop
        'action': 'query',
        'format': 'json',
        'titles': title.trim(),
        'prop': 'extracts',
        'explaintext': '',
      });
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Article.listFromJson(
          jsonData as Map<String, Object?>,
        );
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

  static Future<SearchResults> search(
    String searchTerm,
  ) async {
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
        final jsonData = jsonDecode(response.body);
        return SearchResults.fromJson(
          jsonData as List<Object?>,
        );
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
