import 'package:flutter/material.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/page_link_extension.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelinePageLink extends StatelessWidget {
  const TimelinePageLink(this.summary, {super.key});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(body: Text(summary.titles.normalized));
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 220,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color:
                Theme.of(context).extension<PageLinkTheme>()?.backgroundColor ??
                Colors.white70,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        summary.titles.normalized,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        summary.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
              if (summary.thumbnail != null)
                RoundedImage(
                  source: summary.thumbnail!.source,
                  height: 50,
                  width: 50,
                  borderRadius: BorderRadius.circular(3),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
