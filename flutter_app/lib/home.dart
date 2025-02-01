import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_page_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_page_view.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_app_bar.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_bottom_nav.dart';
import 'package:flutter_app/ui/theme/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

typedef PageElements = (Widget? drawer, Widget? sidebar, Widget? bottomNav);

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // PageElements pageElementSelector(Breakpoint breakpoint, bool isCupertino) {
  //   final props = (isCupertino, breakpoint.width);
  //   final elements = switch (props) {
  //     (_, BreakpointWidth.small) => 'AdaptiveBottomNav',
  //     (true, BreakpointWidth.medium) => 'AdaptiveBottomNav',
  //     (true, BreakpointWidth.large) => 'CupertinoSideBar',
  //     (false, BreakpointWidth.medium) => 'NavigationRail',
  //     (false, BreakpointWidth.large) => 'Drawer',
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    final breakpoint = BreakpointProvider.of(context);

    return Scaffold(
      // TODO(ewindmill): switch for platform
      backgroundColor: AppTheme.cupertinoLightTheme.scaffoldBackgroundColor,
      drawer:
          !context.isCupertino && breakpoint.width == BreakpointWidth.large
              ? NavigationDrawer(children: [Text('Home')])
              : null,
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
