import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/features/feed/widgets/article_preview.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
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
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal:
                BreakpointProvider.of(context).margin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height:
                    BreakpointProvider.of(context).spacing *
                    4,
              ),
              Text(
                AppStrings.today,
                style: TextTheme.of(context).titleLarge,
              ),
              SizedBox(
                height:
                    BreakpointProvider.of(context).spacing *
                    4,
              ),
              FeedItem(
                sectionTitle:
                    AppStrings.todaysFeaturedArticle,
                child: ArticlePreview(
                  summary: viewModel.todaysFeaturedArticle!,
                ),
              ),
              if (viewModel.hasImage)
                SizedBox(
                  height:
                      BreakpointProvider.of(
                        context,
                      ).spacing *
                      4,
                ),
              if (viewModel.hasImage)
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      CupertinoPageRoute<void>(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return ImageModalView(
                            viewModel.imageOfTheDay!,
                          );
                        },
                      ),
                    );
                  },
                  child: FeedItem(
                    sectionTitle: 'Image of the Day',
                    subtitle:
                        'By ${viewModel.imageOfTheDay!.artist}',
                    child: RoundedImage(
                      source:
                          viewModel
                              .imageOfTheDay!
                              .originalImage
                              .source,
                      height: 240,
                      width: BreakpointProvider.appWidth(
                        context,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height:
                    BreakpointProvider.of(context).spacing *
                    4,
              ),
              FeedItem(
                sectionTitle: AppStrings.onThisDay,
                subtitle: viewModel.readableDate,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.of(
                      context,
                    ).pushNamed(Routes.timeline);
                  },
                  child: Column(
                    children: <Widget>[
                      const TimelineCap(),
                      for (final OnThisDayEvent event
                          in viewModel.timelinePreview)
                        TimelineListItem(
                          showPageLinks: false,
                          event: event,
                        ),
                      const TimelineCap(
                        position: CapPosition.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
