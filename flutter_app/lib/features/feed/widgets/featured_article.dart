import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_page_view.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
import 'package:flutter_app/features/saved_articles/save_for_later_button.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class FeaturedArticle extends StatelessWidget {
  const FeaturedArticle({
    required this.featuredArticle,
    required this.header,
    required this.subhead,
    super.key,
  });

  final Summary featuredArticle;
  final String header;
  final String subhead;

  @override
  Widget build(BuildContext context) {
    final breakpoint = BreakpointProvider.of(context);

    return FeedItem(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return ArticleView(summary: featuredArticle);
            },
          ),
        );
      },
      header: header,
      subhead: subhead,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (featuredArticle.originalImage != null)
            RoundedImage(
              source: featuredArticle.originalImage!.source,
              height: itemSize(context).feedItemHeight / 2.5,
              width: double.infinity,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radius),
                topRight: Radius.circular(AppTheme.radius),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              top: breakpoint.padding,
              left: breakpoint.padding,
              right: breakpoint.padding,
            ),
            child: Text(
              featuredArticle.titles.normalized,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.titleMedium!.copyWith(
                fontFamily: AppTheme.serif.fontFamily,
                fontFamilyFallback: AppTheme.serif.fontFamilyFallback,
              ),
            ),
          ),
          if (featuredArticle.description != null)
            Padding(
              padding: EdgeInsets.only(
                left: breakpoint.padding,
                right: breakpoint.padding,
                bottom: breakpoint.padding,
                top: 4,
              ),
              child: Text(
                featuredArticle.description!,
                style: context.textTheme.labelSmall,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: breakpoint.padding,
              right: breakpoint.padding,
            ),
            child: Text(
              featuredArticle.extract,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          const Spacer(),
          SaveForLaterButton(
            label: Text(AppStrings.saveForLater),
            viewModel: SavedArticlesViewModel(
              repository:
                  RepositoryProvider.of(context).savedArticlesRepository,
            ),
            summary: featuredArticle,
          ),
        ],
      ),
    );
  }
}
