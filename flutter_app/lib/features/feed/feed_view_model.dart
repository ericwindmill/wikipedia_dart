import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class FeedViewModel extends ChangeNotifier {
  FeedViewModel() {
    getFeed();
  }

  String error = '';

  bool get hasError => error != '';

  List<Summary> get mostRead => feed?.mostRead ?? [];

  WikipediaFeed? feed;

  Summary? todaysFeaturedArticle;

  List<OnThisDayEvent> get timelinePreview => feed?.onThisDayTimeline ?? [];

  bool get hasImage => feed?.imageOfTheDay?.simpleImage.source != null;

  bool get hasData =>
      feed != null ||
      todaysFeaturedArticle != null ||
      timelinePreview.isNotEmpty;

  Future<void> getFeed() async {
    try {
      feed = await WikipediaApiClient.getWikipediaFeed();
      if (feed == null) throw Exception('_feed is null');

      todaysFeaturedArticle =
          feed!.todaysFeaturedArticle ??
          await WikipediaApiClient.getRandomArticle();

      notifyListeners();
    } on HttpException catch (e) {
      // TODO - handle exception gracefully
      print(e);
      error = e.message;
    } catch (e) {
      print('unknown error $e');
      error = e.toString();
    }
  }
}
