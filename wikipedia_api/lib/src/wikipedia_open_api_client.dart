import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wikipedia_api/src/util.dart';

import '../wikipedia_api.dart';

class WikipediaApiClient {
  static Future<Summary> getRandomArticle() async {
    final client = http.Client();
    try {
      final url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/page/random/summary',
      );
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Summary.fromJson(jsonData);
      } else {
        throw HttpException(
          '[WikipediaDart.getRandomArticle] statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception("Unexpected error - $error");
    } finally {
      client.close();
    }
  }

  // The title must match exactly
  static Future<Summary> getArticleSummary(String articleTitle) async {
    final client = http.Client();
    try {
      final url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/page/summary/$articleTitle',
      );
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Summary.fromJson(jsonData);
      } else {
        throw HttpException(
          '[WikipediaDart.getArticleSummary] statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception("Unexpected error - $error");
    } finally {
      client.close();
    }
  }

  /// [month] and [date] should be 2 digits, padded with a 0 if necessary.
  static Future<OnThisDayTimeline> getTimelineForDate({
    required String month,
    required String date,
  }) async {
    if (!verifyMonthAndDate(month: month, date: date)) {
      throw Exception('Month and date must be valid combination.');
    }

    final client = http.Client();
    try {
      final url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/feed/onthisday/all/$month/$date',
      );
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return OnThisDayTimeline.fromJson(jsonData);
      } else {
        throw HttpException(
          '[WikipediaDart.getTimelineForDate] statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception("Unexpected error - $error");
    } finally {
      client.close();
    }
  }

  final wikimediaExample =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=cat&prop=extracts&explaintext';
  final searchExample =
      'https://en.wikipedia.org/w/api.php?action=opensearch&search=dart';
}
