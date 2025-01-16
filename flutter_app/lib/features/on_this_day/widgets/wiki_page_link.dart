import 'package:flutter/material.dart';
import 'package:shared/wikipedia_api.dart';

import '../../ui/theme_extensions/page_link_extension.dart';

class WikiPageDisplay extends StatelessWidget {
  const WikiPageDisplay(this.page, {super.key});

  final Summary page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 36,
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color:
              Theme.of(context).extension<PageLinkTheme>()?.backgroundColor ??
              Colors.white70,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              page.titles.normalized,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              page.description ?? '',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
