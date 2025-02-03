import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_app_bar.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_bottom_nav.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_scaffold.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final breakpoint = BreakpointProvider.of(context);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: AppStrings.wikipediaDart),
      body:
          <Widget>[
            FeedView(
              viewModel: FeedViewModel(
                repository: RepositoryProvider.of(context).feedRepository,
              ),
            ),
            SavedArticlesView(
              viewModel: SavedArticlesViewModel(
                repository:
                    RepositoryProvider.of(context).savedArticlesRepository,
              ),
            ),
          ][_selectedIndex],
      bottomNavigationBar:
          breakpoint.width == BreakpointWidth.small
              ? AdaptiveBottomNav(
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
              )
              : null,
    );
  }
}
