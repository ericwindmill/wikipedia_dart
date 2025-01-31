import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_page_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/on_this_day/timeline_page_view.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_page_view.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/adaptive_app_bar.dart';
import 'package:flutter_app/ui/adaptive_bottom_nav.dart';
import 'package:flutter_app/ui/theme/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cupertinoLightTheme.scaffoldBackgroundColor,
      appBar: const AdaptiveAppBar(title: 'Wikipedia Dart'),
      body: SafeArea(
        child:
            <Widget>[
              FeedView(
                viewModel: FeedViewModel(
                  repository: RepositoryProvider.of(context).feedRepository,
                ),
              ),
              TimelineView(
                viewModel: TimelineViewModel(
                  repository: RepositoryProvider.of(context).timelineRepository,
                ),
              ),
              SavedArticlesPageView(
                viewModel: SavedArticlesViewModel(
                  repository:
                      RepositoryProvider.of(context).savedArticlesRepository,
                ),
              ),
            ][_selectedIndex],
      ),
      bottomNavigationBar: AdaptiveBottomNav(
        onSelection: (int index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
