import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class FeedViewModel extends ChangeNotifier {
  FeedViewModel() {
    getFeed();
  }

  String error = '';

  bool get hasError => error != '';

  UnmodifiableListView<Summary> get mostRead =>
      UnmodifiableListView(_feed?.mostRead ?? <Summary>[]);

  UnmodifiableListView<OnThisDayEvent>
  get timelinePreview => UnmodifiableListView(
    _feed?.onThisDayTimeline?.take(2).toList() ??
        <OnThisDayEvent>[],
  );

  bool get hasImage =>
      _feed?.imageOfTheDay?.originalImage.source != null;

  WikipediaImage? get imageOfTheDay => _feed?.imageOfTheDay;

  Summary? get todaysFeaturedArticle =>
      _todaysFeaturedArticle;

  String get readableDate => DateTime.now().humanReadable;

  Summary? _todaysFeaturedArticle;
  WikipediaFeed? _feed;

  bool get hasData =>
      _feed != null ||
      todaysFeaturedArticle != null ||
      timelinePreview.isNotEmpty;

  Future<void> getFeed() async {
    try {
      _feed = await WikipediaApiClient.getWikipediaFeed();

      // As a fallback, show a random article
      _todaysFeaturedArticle =
          _feed!.todaysFeaturedArticle ??
          await WikipediaApiClient.getRandomArticle();

      notifyListeners();
    } on HttpException catch (e) {
      // TODO - handle exception gracefully
      error = e.message;
    }
  }
}
