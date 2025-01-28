import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class FeedViewModel extends ChangeNotifier {
  FeedViewModel() {
    getFeed();
  }

  String error = '';

  bool get hasError => error != '';

  UnmodifiableListView<Summary> get mostRead =>
      UnmodifiableListView<Summary>(_feed?.mostRead?.take(5) ?? <Summary>[]);

  UnmodifiableListView<OnThisDayEvent> get timelinePreview =>
      UnmodifiableListView<OnThisDayEvent>(
        _feed?.onThisDayTimeline?.take(2).toList() ?? <OnThisDayEvent>[],
      );

  bool get hasImage => _feed?.imageOfTheDay?.originalImage.source != null;

  WikipediaImage? get imageOfTheDay => _feed?.imageOfTheDay;

  String get imageArtist {
    if (hasImage && imageOfTheDay!.artist != null) {
      return imageOfTheDay!.artist!;
    }

    return '';
  }

  Summary? get todaysFeaturedArticle => _todaysFeaturedArticle;

  Summary? get randomArticle => _randomArticle;

  String get readableDate => DateTime.now().humanReadable;

  Summary? _todaysFeaturedArticle;
  Summary? _randomArticle;
  WikipediaFeed? _feed;

  bool get hasData =>
      _feed != null ||
      todaysFeaturedArticle != null ||
      timelinePreview.isNotEmpty ||
      _randomArticle != null;

  Future<void> getFeed() async {
    try {
      _feed = await WikipediaApiClient.getWikipediaFeed();

      // As a fallback, show a random article
      _todaysFeaturedArticle =
          _feed!.todaysFeaturedArticle ??
          await WikipediaApiClient.getRandomArticle();

      _randomArticle = await WikipediaApiClient.getRandomArticle();
    } on HttpException catch (e) {
      debugPrint(e.toString());
      error = AppStrings.failedToGetTimelineDataFromWikipedia;
    } on FormatException catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
