import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

const String dartLangSummaryJson =
    './test/test_data/dart_lang_summary.json';
const String terryItoInnerJson =
    './test/test_data/terry_ito_inner.json';
const String onThisDayPath =
    './test/test_data/on_this_day_response_example.json';
const String brockPurdyInnerJson =
    './test/test_data/brock_purdy_inner.json';
const String catExtractJson =
    './test/test_data/cat_extract.json';
const String openSearchResponse =
    './test/test_data/open_search_response.json';
const String wikipediaFeedResponse =
    './test/test_data/wikipedia_feed_response.json';
const String churchImageJson =
    './test/test_data/church_image.json';

void main() {
  group(
    'deserialize example JSON responses from wikipedia API',
    () {
      test(
        'deserialize Terry Ito page on-this-day example data from '
        'json file into an OnThisDayInner object',
        () async {
          final String pageSummaryInput =
              await File(terryItoInnerJson).readAsString();
          final pageSummaryMap = jsonDecode(
            pageSummaryInput,
          );
          final OnThisDayEvent summary =
              OnThisDayEvent.fromJson(
                pageSummaryMap as Map<String, Object>,
                EventType.birthday,
              );
          expect(summary.year, 1949);
        },
      );

      test(
        'deserialize Dart Programming Language page summary example data from '
        'json file into a Summary object',
        () async {
          final String pageSummaryInput =
              await File(
                dartLangSummaryJson,
              ).readAsString();
          final dynamic pageSummaryMap = jsonDecode(
            pageSummaryInput,
          );
          final Summary summary = Summary.fromJson(
            pageSummaryMap as Map<String, Object>,
          );
          expect(
            summary.titles.canonical,
            'Dart_(programming_language)',
          );
        },
      );

      test(
        'deserialize Brock Purdy on-this-day example data from json file into '
        'an OnThisDayInner object',
        () async {
          final String onThisDayInnerInput =
              await File(
                brockPurdyInnerJson,
              ).readAsString();
          final onThisDayInnerMap = jsonDecode(
            onThisDayInnerInput,
          );
          final OnThisDayEvent onThisDayInner =
              OnThisDayEvent.fromJson(
                onThisDayInnerMap as Map<String, Object>,
                EventType.birthday,
              );
          expect(onThisDayInner.year, 1999);
        },
      );

      test(
        'deserialize on this day test data from json file into an '
        'OnThisDayResponse object',
        () async {
          final String onThisDayInput =
              await File(onThisDayPath).readAsString();
          final onThisDayMap = jsonDecode(onThisDayInput);
          final OnThisDayTimeline onThisDayResponse =
              OnThisDayTimeline.fromJson(
                onThisDayMap as Map<String, Object>,
              );
          expect(onThisDayResponse.selected.length, 15);
        },
      );
    },
  );

  group(
    'deserialize example JSON responses from wikipedia API',
    () {
      test(
        'deserialize Cat article example data from json file into '
        'an Article object',
        () async {
          final String articleJson =
              await File(catExtractJson).readAsString();
          final articleAsMap = jsonDecode(articleJson);
          final List<Article> article =
              Article.listFromJson(
                articleAsMap as Map<String, Object>,
              );
          expect(article.first.title.toLowerCase(), 'cat');
        },
      );

      test(
        'deserialize Open Search results example data from json file '
        'into an SearchResults object',
        () async {
          final String resultsString =
              await File(openSearchResponse).readAsString();
          final resultsAsList = jsonDecode(resultsString);
          final SearchResults results =
              SearchResults.fromJson(
                resultsAsList as List<Object?>,
              );
          expect(results.results.length, greaterThan(1));
        },
      );

      test(
        'deserialize WikipediaFeed results from json file',
        () async {
          final String resultsString =
              await File(
                wikipediaFeedResponse,
              ).readAsString();
          final resultsAsMap = jsonDecode(resultsString);
          final WikipediaFeed feed = WikipediaFeed.fromJson(
            resultsAsMap as Map<String, Object>,
          );
          expect(feed, isNotNull);
        },
      );

      test(
        'deserialize image results from json file',
        () async {
          final String resultsString =
              await File(churchImageJson).readAsString();
          final resultsAsMap = jsonDecode(resultsString);
          final WikipediaImage image =
              WikipediaImage.fromJson(
                resultsAsMap as Map<String, Object>,
              );
          expect(image, isNotNull);
        },
      );
    },
  );
}
