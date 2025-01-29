import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline_list_item.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline_painter.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelinePreview extends StatelessWidget {
  const TimelinePreview({
    required this.timelinePreviewItems,
    required this.readableDate,
    super.key,
  });

  final String readableDate;
  final List<OnThisDayEvent> timelinePreviewItems;

  @override
  Widget build(BuildContext context) {
    return FeedItem(
      header: AppStrings.onThisDay,
      subhead: readableDate,
      onTap: () async {
        await Navigator.of(context).pushNamed(Routes.timeline);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const TimelineCap(),
          for (final OnThisDayEvent event in timelinePreviewItems)
            Flexible(
              child: TimelineListItem(
                showPageLinks: false,
                event: event,
                maxLines: 2,
              ),
            ),
          const TimelineCap(position: CapPosition.bottom),
        ],
      ),
    );
  }
}
