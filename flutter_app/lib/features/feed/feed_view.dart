import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/widgets/timeline_preview.dart';
import 'package:flutter_app/features/ui/shared_widgets/article_summary.dart';

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
          return Center(child: Text(viewModel.error!));
        }
        if (!viewModel.hasData && !viewModel.hasError) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Featured Article"),
            ArticleSummary(summary: viewModel.todaysFeaturedArticle!),
            Text("On this day"),
            TimelinePreview(events: viewModel.timelinePreview),
            Text('Image of the Day'),
            if (viewModel.hasImage)
              Text(viewModel.feed!.imageOfTheDay!.simpleImage.source),
          ],
        );
      },
    );
  }
}
