import 'package:flutter/cupertino.dart';

import 'package:flutter_app/features/on_this_day/timeline_view.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/features/random_article/random_article_view.dart';
import 'package:flutter_app/features/random_article/random_article_view_model.dart';

abstract final class Routes {
  static const timeline = '/timeline';
  static const randomArticle = '/randomArticle';
}

final routes = <String, WidgetBuilder>{
  Routes.timeline: (context) => TimelineView(viewModel: TimelineViewModel()),
  Routes.randomArticle:
      (context) => RandomArticleView(viewModel: RandomArticleViewModel()),
};
