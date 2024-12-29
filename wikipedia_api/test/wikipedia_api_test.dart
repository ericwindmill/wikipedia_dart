@TestOn('vm')
library;

import 'package:wikipedia_api/src/util.dart';
import 'package:wikipedia_api/wikipedia_api.dart';
import 'package:test/test.dart';

void main() {
  group('Fetch from Wikipedia API', () {
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

  group('Fetch from wikimedia api', () {
    test('Fetches cat article extract from wikipedia', () async {
      final articles = await WikimediaApiClient.getArticleByTitle('cat');
      expect(articles.length, greaterThan(0));
      expect(articles.first.title.toLowerCase(), 'cat');
    });

    test(
      "Handles disambiguation page when article title doesn't match a wikipedia article name",
      () async {
        final articles = await WikimediaApiClient.getArticleByTitle('dart');
        expect(articles.length, greaterThan(0));
        expect(articles.first.title.toLowerCase(), 'dart');
      },
    );

    test('Handles searching', () async {
      final searchResults = await WikimediaApiClient.search('dart');
      expect(searchResults.searchTerm, 'dart');
      expect(searchResults.results.length, greaterThan(0));
    });
  });
}
