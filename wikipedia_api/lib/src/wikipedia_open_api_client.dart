import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../wikipedia_api.dart';

class WikipediaApiClient {
  static Future<Summary> getRandomArticle() async {
    final http.Client client = http.Client();
    try {
      final Uri url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/page/random/summary',
      );
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Summary.fromJson(
          jsonData as Map<String, Object?>,
        );
      } else {
        throw HttpException(
          '[WikipediaDart.getRandomArticle] '
          'statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception('Unexpected error - $error');
    } finally {
      client.close();
    }
  }

  // The title must match exactly
  static Future<Summary> getArticleSummary(
    String articleTitle,
  ) async {
    final http.Client client = http.Client();
    try {
      final Uri url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/page/summary/$articleTitle',
      );
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Summary.fromJson(
          jsonData as Map<String, Object?>,
        );
      } else {
        throw HttpException(
          '[WikipediaDart.getArticleSummary] '
          'statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception('Unexpected error - $error');
    } finally {
      client.close();
    }
  }

  /// [month] and [date] should be 2 digits, padded with a 0 if necessary.
  static Future<OnThisDayTimeline> getTimelineForDate({
    required int month,
    required int day,
    // Be default, fetch all types.
    EventType? type,
  }) async {
    if (!verifyMonthAndDate(month: month, day: day)) {
      throw Exception(
        'Month and date must be valid combination.',
      );
    }

    final String strMonth = toStringWithPad(month);
    final String strDay = toStringWithPad(day);
    final String strType =
        type == null ? 'all' : type.apiStr;

    final http.Client client = http.Client();
    try {
      final Uri url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/feed/onthisday/$strType/$strMonth/$strDay',
      );

      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return OnThisDayTimeline.fromJson(
          jsonData as Map<String, Object?>,
        );
      } else {
        throw HttpException(
          '[WikipediaDart.getTimelineForDate] '
          'statusCode=${response.statusCode}, body=${response.body}',
        );
      }
    } on Exception catch (error) {
      throw Exception('Unexpected error - $error');
    } finally {
      client.close();
    }
  }

  static Future<WikipediaFeed> getWikipediaFeed() async {
    final DateTime date = DateTime.now();
    final int year = date.year;
    final String month = toStringWithPad(date.month);
    final String day = toStringWithPad(date.day);
    final http.Client client = http.Client();
    try {
      final Uri url = Uri.https(
        'en.wikipedia.org',
        '/api/rest_v1/feed/featured/$year/$month/$day',
      );
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return WikipediaFeed.fromJson(
          jsonData as Map<String, Object?>,
        );
      } else {
        throw HttpException(
          '[WikipediaDart.getWikipediaFeed] '
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
