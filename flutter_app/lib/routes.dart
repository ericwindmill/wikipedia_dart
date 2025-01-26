import 'package:flutter/cupertino.dart';

import 'package:flutter_app/features/on_this_day/timeline_view.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/features/random_article/random_article_view.dart';
import 'package:flutter_app/features/random_article/random_article_view_model.dart';

abstract final class Routes {
  static const String timeline = '/timeline';
  static const String randomArticle = '/randomArticle';
}

final Map<String, WidgetBuilder> routes =
    <String, WidgetBuilder>{
      Routes.timeline:
          (BuildContext context) =>
              TimelineView(viewModel: TimelineViewModel()),
      Routes.randomArticle:
          (BuildContext context) => RandomArticleView(
            viewModel: RandomArticleViewModel(),
          ),
    };
