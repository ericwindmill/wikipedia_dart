import 'dart:convert';
import 'dart:io';

import 'package:wikipedia_api/wikipedia_api.dart';
import 'package:test/test.dart';

final dartLangSummaryJson = './test/test_data/dart_lang_summary.json';
final terryItoInnerJson = './test/test_data/terry_ito_inner.json';
final onThisDayPath = './test/test_data/on_this_day_response_example.json';
final brockPurdyInnerJson = './test/test_data/brock_purdy_inner.json';
final catExtractJson = './test/test_data/cat_extract.json';
final openSearchResponse = './test/test_data/open_search_response.json';
final wikipediaFeedResponse = './test/test_data/wikipedia_feed_response.json';
final churchImageJson = './test/test_data/church_image.json';

void main() {
  group("deserialize example JSON responses from wikipedia API", () {
    test(
      'deserialize Terry Ito page on-this-day example data from json file into an OnThisDayInner object',
      () async {
        var pageSummaryInput = await File(terryItoInnerJson).readAsString();
        var pageSummaryMap = jsonDecode(pageSummaryInput);
        final OnThisDayEvent summary = OnThisDayEvent.fromJson(
          pageSummaryMap,
          EventType.birthday,
        );
        expect(summary.year, 1949);
      },
    );

    test(
      'deserialize Dart Programming Language page summary example data from json file into a Summary object',
      () async {
        var pageSummaryInput = await File(dartLangSummaryJson).readAsString();
        var pageSummaryMap = jsonDecode(pageSummaryInput);
        final Summary summary = Summary.fromJson(pageSummaryMap);
        expect(summary.titles.canonical, 'Dart_(programming_language)');
      },
    );

    test(
      'deserialize Brock Purdy on-this-day example data from json file into an OnThisDayInner object',
      () async {
        var onThisDayInnerInput =
            await File(brockPurdyInnerJson).readAsString();
        var onThisDayInnerMap = jsonDecode(onThisDayInnerInput);
        OnThisDayEvent onThisDayInner = OnThisDayEvent.fromJson(
          onThisDayInnerMap,
          EventType.birthday,
        );
        expect(onThisDayInner.year, 1999);
      },
    );

    test(
      'deserialize on this day test data from json file into an OnThisDayResponse object',
      () async {
        var onThisDayInput = await File(onThisDayPath).readAsString();
        var onThisDayMap = jsonDecode(onThisDayInput);
        OnThisDayTimeline onThisDayResponse = OnThisDayTimeline.fromJson(
          onThisDayMap,
        );
        expect(onThisDayResponse.selected.length, 15);
      },
    );
  });

  group("deserialize example JSON responses from wikipedia API", () {
    test(
      'deserialize Cat article example data from json file into an Article object',
      () async {
        var articleJson = await File(catExtractJson).readAsString();
        var articleAsMap = jsonDecode(articleJson);
        final List<Article> article = Article.listFromJson(articleAsMap);
        expect(article.first.title.toLowerCase(), 'cat');
      },
    );

    test(
      'deserialize Open Search results example data from json file into an SearchResults object',
      () async {
        var resultsString = await File(openSearchResponse).readAsString();
        var resultsAsList = jsonDecode(resultsString);
        final SearchResults results = SearchResults.fromJson(resultsAsList);
        expect(results.results.length, greaterThan(1));
      },
    );

    test('deserialize WikipediaFeed results from json file', () async {
      var resultsString = await File(wikipediaFeedResponse).readAsString();
      var resultsAsMap = jsonDecode(resultsString);
      final WikipediaFeed feed = WikipediaFeed.fromJson(resultsAsMap);
      expect(feed, isNotNull);
    });

    test('deserialize image results from json file', () async {
      var resultsString = await File(churchImageJson).readAsString();
      var resultsAsMap = jsonDecode(resultsString);
      final WikipediaImage image = WikipediaImage.fromJson(resultsAsMap);
      expect(image, isNotNull);
    });
  });
}
