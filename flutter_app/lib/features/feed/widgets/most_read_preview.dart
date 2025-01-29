import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_view.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class MostReadView extends StatelessWidget {
  const MostReadView({required this.topReadArticles, super.key});

  final List<Summary> topReadArticles;

  @override
  Widget build(BuildContext context) {
    final Breakpoint breakpoint = BreakpointProvider.of(context);
    return FeedItem(
      header: AppStrings.mostRead,
      subhead: AppStrings.fromToday,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: topReadArticles.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4);
        },
        itemBuilder: (BuildContext context, int index) {
          final Color iconColor =
              [
                AppColors.flutterBlue5,
                AppColors.violet,
                AppColors.flutterBlue4,
                AppColors.teal,
              ][index % 4];
          final Summary summary = topReadArticles[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return ArticleView(summary: summary);
                  },
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(breakpoint.padding),
              child: Row(
                spacing: breakpoint.spacing,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(side: BorderSide(color: iconColor)),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextTheme.of(context).labelSmall,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(summary.titles.normalized),
                        if (summary.description != null)
                          Text(
                            summary.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextTheme.of(context).labelMedium,
                          ),
                      ],
                    ),
                  ),
                  if (summary.thumbnail != null)
                    RoundedImage(
                      borderRadius: BorderRadius.circular(2.0),
                      source: summary.thumbnail!.source,
                      height: 30,
                      width: 30,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
