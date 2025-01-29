import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/feed/widgets/featured_article.dart';
import 'package:flutter_app/features/feed/widgets/featured_image.dart';
import 'package:flutter_app/features/feed/widgets/most_read_preview.dart';
import 'package:flutter_app/features/feed/widgets/timeline_preview.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';

class FeedView extends StatelessWidget {
  const FeedView({required this.viewModel, super.key});

  final FeedViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, _) {
        // TODO(ewindmill): handle errors
        if (viewModel.hasError) {
          return Center(child: Text(viewModel.error));
        }
        if (!viewModel.hasData && !viewModel.hasError) {
          return const Center(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: BreakpointProvider.of(context).margin,
          ),
          child: Column(
            spacing: BreakpointProvider.of(context).spacing,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: BreakpointProvider.of(context).padding,
                ),
                child: Text(
                  AppStrings.today,
                  style: TextTheme.of(context).headlineSmall,
                ),
              ),
              Wrap(
                spacing: BreakpointProvider.of(context).spacing,
                runSpacing: BreakpointProvider.of(context).spacing,
                children: [
                  if (viewModel.todaysFeaturedArticle != null)
                    FeaturedArticle(
                      header: AppStrings.todaysFeaturedArticle,
                      subhead: AppStrings.fromLanguageWikipedia,
                      featuredArticle: viewModel.todaysFeaturedArticle!,
                    ),
                  if (viewModel.hasImage)
                    FeaturedImage(
                      image: viewModel.imageOfTheDay!,
                      imageFile: viewModel.imageSource!,
                      readableDate: viewModel.readableDate,
                    ),
                  if (viewModel.timelinePreview.isNotEmpty)
                    TimelinePreview(
                      timelinePreviewItems: viewModel.timelinePreview,
                      readableDate: viewModel.readableDate,
                    ),
                  if (viewModel.mostRead.isNotEmpty)
                    MostReadView(topReadArticles: viewModel.mostRead),
                  if (viewModel.randomArticle != null)
                    FeaturedArticle(
                      header: AppStrings.randomArticle,
                      subhead: AppStrings.fromLanguageWikipedia,
                      featuredArticle: viewModel.randomArticle!,
                    ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
