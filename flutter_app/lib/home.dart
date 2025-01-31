import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_page_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_page_view.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/adaptive_app_bar.dart';
import 'package:flutter_app/ui/adaptive_bottom_nav.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:flutter_app/util.dart';

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
      appBar: AdaptiveAppBar(title: AppStrings.wikipediaDart),
      body: SafeArea(
        child:
            <Widget>[
              FeedPageView(
                viewModel: FeedViewModel(
                  repository: RepositoryProvider.of(context).feedRepository,
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
        navigationItems: {
          'Explore':
              context.isCupertino
                  ? const Icon(CupertinoIcons.house_fill)
                  : const Icon(Icons.home),
          'Saved for Later':
              context.isCupertino
                  ? const Icon(CupertinoIcons.bookmark)
                  : const Icon(Icons.bookmark_border),
        },
        onSelection: (int index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
