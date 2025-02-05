import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_scaffold.dart';

enum Destinations {
  explore('Explore', Icons.home, CupertinoIcons.house_fill),
  savedArticles('Saved', Icons.bookmark_border, CupertinoIcons.bookmark);

  const Destinations(this.label, this.materialIcon, this.cupertinoIcon);

  final String label;
  final IconData materialIcon;
  final IconData cupertinoIcon;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: AppStrings.wikipediaDart,
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
        SavedArticlesView(
          viewModel: SavedArticlesViewModel(
            repository: RepositoryProvider.of(context).savedArticlesRepository,
          ),
        ),
      ],
    );
  }
}
