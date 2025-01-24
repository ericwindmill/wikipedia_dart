import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import 'article_summary.dart';
import '../theme_extensions/page_link_extension.dart';

class WikiPageDisplayLink extends StatelessWidget {
  const WikiPageDisplayLink(this.summary, {super.key});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(body: ArticleSummary(summary: summary));
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 70,
          width: 220,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color:
                Theme.of(context).extension<PageLinkTheme>()?.backgroundColor ??
                Colors.white70,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        summary.titles.normalized,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        summary.description ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
              if (summary.thumbnail != null)
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      summary.thumbnail!.source,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 50,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
