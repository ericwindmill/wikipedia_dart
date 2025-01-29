import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_view.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/theme/dimensions.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class FeaturedArticle extends StatelessWidget {
  const FeaturedArticle({
    required this.featuredArticle,
    required this.header,
    super.key,
  });

  final Summary featuredArticle;
  final String header;

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (featuredArticle.originalImage != null)
            RoundedImage(
              source: featuredArticle.originalImage!.source,
              height: itemSize(context).feedItemHeight / 2.5,
              width: double.infinity,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius),
                topRight: Radius.circular(Dimensions.radius),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              top: BreakpointProvider.of(context).padding,
              left: BreakpointProvider.of(context).padding,
              right: BreakpointProvider.of(context).padding,
            ),
            child: Text(
              featuredArticle.titles.normalized,
              style: TextTheme.of(context).titleMedium!.copyWith(
                fontFamily: AppTheme.serif.fontFamily,
                fontFamilyFallback: AppTheme.serif.fontFamilyFallback,
              ),
            ),
          ),
          if (featuredArticle.description != null)
            Padding(
              padding: EdgeInsets.only(
                left: BreakpointProvider.of(context).padding,
                right: BreakpointProvider.of(context).padding,
                bottom: BreakpointProvider.of(context).padding,
              ),
              child: Text(
                featuredArticle.description!,
                style: TextTheme.of(context).labelMedium,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: BreakpointProvider.of(context).padding,
              right: BreakpointProvider.of(context).padding,
            ),
            child: Text(
              featuredArticle.extract,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_border_outlined,
                color: AppColors.primary,
                size: Dimensions.iconSize,
              ),
              label: Text(
                AppStrings.saveForLater,
                style: TextTheme.of(
                  context,
                ).labelMedium!.copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
