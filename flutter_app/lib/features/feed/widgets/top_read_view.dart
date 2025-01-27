import 'package:flutter/material.dart';
import 'package:flutter_app/features/random_article/article_view.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TopReadView extends StatelessWidget {
  const TopReadView({required this.topReadArticles, super.key});

  final List<Summary> topReadArticles;

  @override
  Widget build(BuildContext context) {
    final Breakpoint breakpoint = BreakpointProvider.of(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: topReadArticles.length,
      itemBuilder: (BuildContext context, int index) {
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
              spacing: BreakpointProvider.of(context).spacing,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(breakpoint.padding),
                  child: Text('${index + 1}'),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: breakpoint.spacing * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(topReadArticles[index].titles.normalized),
                        Text(
                          topReadArticles[index].description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextTheme.of(context).labelMedium,
                        ),
                      ],
                    ),
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
    );
  }
}
