import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/feed/widgets/article_preview.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
import 'package:flutter_app/features/feed/widgets/top_read_view.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/shared_widgets/image_modal_view.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

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
            spacing: BreakpointProvider.of(context).spacing * 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppStrings.today, style: TextTheme.of(context).titleLarge),
              FeedItem(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return ArticleView(
                          summary: viewModel.todaysFeaturedArticle!,
                        );
                      },
                    ),
                  );
                },
                sectionTitle: AppStrings.todaysFeaturedArticle,
                child: ArticlePreview(
                  summary: viewModel.todaysFeaturedArticle!,
                ),
              ),
              FeedItem(
                sectionTitle: AppStrings.onThisDay,
                subtitle: viewModel.readableDate,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).pushNamed(Routes.timeline);
                  },
                  child: Column(
                    children: <Widget>[
                      const TimelineCap(),
                      for (final OnThisDayEvent event
                          in viewModel.timelinePreview)
                        TimelineListItem(showPageLinks: false, event: event),
                      const TimelineCap(position: CapPosition.bottom),
                    ],
                  ),
                ),
              ),
              if (viewModel.hasImage)
                FeedItem(
                  sectionTitle: AppStrings.imageOfTheDay,
                  subtitle:
                      viewModel.imageArtist.isNotEmpty
                          ? AppStrings.by(viewModel.imageArtist)
                          : '',
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        CupertinoModalPopupRoute<void>(
                          barrierColor: Colors.black87,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return ImageModalView(
                              viewModel.imageOfTheDay!,
                              title: AppStrings.imageOfTheDayFor(
                                viewModel.readableDate,
                              ),
                              attribution: viewModel.imageArtist,
                              description: viewModel.imageOfTheDay!.description,
                            );
                          },
                        ),
                      );
                    },
                    child: RoundedImage(
                      source: viewModel.imageOfTheDay!.originalImage.source,
                      height: 240,
                      width: BreakpointProvider.appWidth(context),
                    ),
                  ),
                ),
              if (viewModel.mostRead.isNotEmpty)
                FeedItem(
                  sectionTitle: AppStrings.topRead,
                  child: TopReadView(topReadArticles: viewModel.mostRead),
                ),
              if (viewModel.randomArticle != null)
                FeedItem(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return ArticleView(summary: viewModel.randomArticle!);
                        },
                      ),
                    );
                  },
                  sectionTitle: AppStrings.randomArticle,
                  child: ArticlePreview(summary: viewModel.randomArticle!),
                ),
              SizedBox(height: BreakpointProvider.of(context).spacing * 10),
            ],
          ),
        );
      },
    );
  }
}
