import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/on_this_day/timeline_page_view.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/providers/repository_provider.dart';

abstract final class Routes {
  static const String home = '/';
  static const String timeline = '/timeline';
  static const String randomArticle = '/randomArticle';
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  Routes.home: (BuildContext context) => const HomeView(),
  Routes.timeline:
      (BuildContext context) => TimelinePageView(
        viewModel: TimelineViewModel(
          repository: RepositoryProvider.of(context).timelineRepository,
        ),
      ),
};
