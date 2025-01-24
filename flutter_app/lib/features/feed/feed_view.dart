import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/widgets/article_preview.dart';
import 'package:flutter_app/features/ui/app_localization.dart';
import 'package:flutter_app/features/ui/breakpoint.dart';

import '../ui/theme.dart';
import 'feed_view_model.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key, required this.viewModel});

  final FeedViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.hasError) {
          return Center(child: Text(viewModel.error));
        }
        if (!viewModel.hasData && !viewModel.hasError) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        return ListView(
          children: [
            _FeedItem(
              sectionTitle: AppStrings.todaysFeaturedArticle,
              child: ArticlePreview(summary: viewModel.todaysFeaturedArticle!),
            ),

            // Text("On this day"),
            // TimelinePreview(events: viewModel.timelinePreview),
            // Text('Image of the Day'),
            // if (viewModel.hasImage)
            //   Text(viewModel.feed!.imageOfTheDay!.simpleImage.source),
          ],
        );
      },
    );
  }
}

class _FeedItem extends StatelessWidget {
  const _FeedItem({super.key, required this.sectionTitle, required this.child});

  final String sectionTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(sectionTitle, style: TextTheme.of(context).titleLarge),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          padding: EdgeInsets.all(BreakpointProvider.of(context).padding),
          child: child,
        ),
      ],
    );
  }
}
