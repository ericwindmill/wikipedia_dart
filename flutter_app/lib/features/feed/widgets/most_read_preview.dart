import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_page_view.dart';
import 'package:flutter_app/features/article_view/article_view_model.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:flutter_app/util.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class MostReadView extends StatelessWidget {
  const MostReadView({required this.topReadArticles, super.key});

  final List<Summary> topReadArticles;

  Future<void> _onTap(BuildContext context, Summary summary) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return ArticleView(
            viewModel: ArticleViewModel(
              summary,
              repository: RepositoryProvider.of(context).articleRepository,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Breakpoint breakpoint = BreakpointProvider.of(context);
    return FeedItem(
      header: AppStrings.mostRead,
      subhead: AppStrings.fromToday,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: breakpoint.padding / 2),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: topReadArticles.length,
          separatorBuilder: (context, index) {
            return const Divider(height: .1, thickness: .1);
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
            final trailing = RoundedImage(
              borderRadius: BorderRadius.circular(2.0),
              source: summary.thumbnail!.source,
              height: 30,
              width: 30,
            );

            final leading = Container(
              height: 20,
              width: 20,
              decoration: ShapeDecoration(
                shape: CircleBorder(side: BorderSide(color: iconColor)),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: context.textTheme.labelSmall,
                ),
              ),
            );

            return context.isCupertino
                ? CupertinoListTile(
                  backgroundColor: Colors.white,
                  leading: leading,
                  title: Text(summary.titles.normalized),
                  subtitle: Text(summary.description ?? ''),
                  trailing: trailing,
                  onTap: () => _onTap(context, summary),
                )
                : ListTile(
                  title: Text(summary.titles.normalized),
                  subtitle: Text(summary.description ?? ''),
                  trailing: trailing,
                  onTap: () {},
                );

            // return GestureDetector(
            //   onTap: () async {
            //     await Navigator.of(context).push(
            //       MaterialPageRoute<void>(
            //         builder: (BuildContext context) {
            //           return ArticleView(
            //             viewModel: ArticleViewModel(
            //               summary,
            //               repository:
            //                   RepositoryProvider.of(context).articleRepository,
            //             ),
            //           );
            //         },
            //       ),
            //     );
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.all(breakpoint.padding),
            //     child: Row(
            //       spacing: breakpoint.spacing,
            //       children: <Widget>[
            //         Container(
            //           height: 20,
            //           width: 20,
            //           decoration: ShapeDecoration(
            //             shape: CircleBorder(side: BorderSide(color: iconColor)),
            //           ),
            //           child: Center(
            //             child: Text(
            //               '${index + 1}',
            //               style: context.textTheme.labelSmall,
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: <Widget>[
            //               Text(summary.titles.normalized),
            //               if (summary.description != null)
            //                 Text(
            //                   summary.description!,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: context.textTheme.labelSmall,
            //                 ),
            //             ],
            //           ),
            //         ),
            //         if (summary.thumbnail != null)
            //
            //       ],
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
