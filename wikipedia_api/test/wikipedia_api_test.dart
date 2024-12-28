@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';
import 'package:wikipedia_api/src/util.dart';
import 'package:wikipedia_api/src/wikipedia_api_client.dart';
import 'package:wikipedia_api/wikipedia_api.dart';
import 'package:test/test.dart';

final dartLangSummaryJson = './assets/dart_lang_summary.json';
final terryItoInnerJson = './assets/terry_ito_inner.json';
final onThisDayPath = './assets/on_this_day_response_example.json';
final brockPurdyInnerJson = './assets/brock_purdy_inner.json';

void main() {
  group("deserialize example JSON responses from wikipedia API", () {
    test(
      'deserialize Terry Ito page on-this-day example data from json file into an OnThisDayInner object',
      () async {
        var pageSummaryInput = await File(terryItoInnerJson).readAsString();
        var pageSummaryMap = jsonDecode(pageSummaryInput);
        final OnThisDayEvent summary = OnThisDayEvent.fromJson(pageSummaryMap);
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

  group('Can fetch from Wikipedia API', () {
    test('Fetches cat page from wikipedia', () async {
      final summary = await WikipediaApiClient.getArticleSummary('cat');
      expect(summary, isNotNull);
      expect(summary.titles.normalized.toLowerCase(), 'cat');
    });

    test('Fetches random article summary from wikipedia', () async {
      final summary = await WikipediaApiClient.getRandomArticle();
      expect(summary, isNotNull);
    });

    test("Fetches 'on this day' timeline from Wikipedia", () async {
      final timeline = await WikipediaApiClient.getTimelineForDate(
        month: toStringWithPad(8),
        date: toStringWithPad(2),
      );
      expect(timeline.selected, isNotEmpty);
    });
  });
}
