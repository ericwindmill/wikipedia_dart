import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/on_this_day/timeline_page_view.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_tab_scaffold.dart';

enum Destinations {
  explore('Explore', Icons.home, CupertinoIcons.house_fill),
  timeline('Timeline', Icons.calendar_today_outlined, CupertinoIcons.calendar),
  savedArticles('Saved', Icons.bookmark_border, CupertinoIcons.bookmark);

  const Destinations(this.label, this.materialIcon, this.cupertinoIcon);

  final String label;
  final IconData materialIcon;
  final IconData cupertinoIcon;
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTabScaffold(
      title: Text(AppStrings.wikipediaDart, style: context.titleLarge),
      collapsedTitle: Text('W', style: context.titleLarge),
      automaticallyImplyLeading: false,
      actions: [
        if (context.isCupertino)
          IconButton(
            icon: const Icon(CupertinoIcons.person_alt_circle),
            onPressed: () {},
          ),
        if (!context.isCupertino) const CircleAvatar(child: Text('P')),
      ],
      navigationItems: {
        for (final d in Destinations.values)
          d.label: context.isCupertino ? d.cupertinoIcon : d.materialIcon,
      },
      tabs: <Widget>[
        FeedView(
          viewModel: FeedViewModel(
            repository: RepositoryProvider.of(context).feedRepository,
          ),
        ),
        TimelinePageView(
          viewModel: TimelineViewModel(
            repository: RepositoryProvider.of(context).timelineRepository,
          ),
        ),
        SavedArticlesView(
          viewModel: SavedArticlesViewModel(
            repository: RepositoryProvider.of(context).savedArticlesRepository,
          ),
        ),
      ],
    );
  }
}
