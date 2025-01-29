import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wikipedia_api/wikipedia_api.dart';

class FeedRepository {
  WikipediaFeed? _cachedFeed;

  Summary? _cachedRandomArticle;

  Future<WikipediaFeed> getWikipediaFeed() async {
    if (_cachedFeed != null) return _cachedFeed!;

    final http.Client client = http.Client();
    final Uri url = Uri.http('localhost:8888', '/feed');
    final http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, Object?> jsonData =
          jsonDecode(response.body) as Map<String, Object?>;
      _cachedFeed = WikipediaFeed.fromJson(jsonData);
      return _cachedFeed!;
    } else {
      throw HttpException(
        '[WikipediaDart.getWikipediaFeed] '
        'statusCode=${response.statusCode}, '
        'body=${response.body}',
      );
    }
  }

  Future<Summary> getRandomArticle() async {
    if (_cachedRandomArticle != null) return _cachedRandomArticle!;

    final http.Client client = http.Client();
    final Uri url = Uri.http('localhost:8888', '/random');
    final http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, Object?> jsonData =
          jsonDecode(response.body) as Map<String, Object?>;
      _cachedRandomArticle = Summary.fromJson(jsonData);
      return _cachedRandomArticle!;
    } else {
      throw HttpException(
        '[WikipediaDart.getWikipediaFeed] '
        'statusCode=${response.statusCode}, '
        'body=${response.body}',
      );
    }
  }
}
