import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/widgets/feed_item_container.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/breakpoint.dart';
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

  (double, double) _capSize(BreakpointWidth breakpointWidth) {
    return switch (breakpointWidth) {
      BreakpointWidth.small => (4.0, 4.0),
      BreakpointWidth.medium => (0.0, 0.0),
      BreakpointWidth.large => (0.0, 0.0),
    };
  }

  @override
  Widget build(BuildContext context) {
    final breakpointWidth = BreakpointProvider.of(context).width;
    return FeedItem(
      header: AppStrings.onThisDay,
      subhead: readableDate,
      onTap: () async {
        await Navigator.of(context).pushNamed(Routes.timeline);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TimelineCap(height: _capSize(breakpointWidth).$1),
          for (final OnThisDayEvent event in timelinePreviewItems)
            TimelineListItem(showPageLinks: false, event: event, maxLines: 2),
          TimelineCap(
            position: CapPosition.bottom,
            height: _capSize(breakpointWidth).$2,
          ),
        ],
      ),
    );
  }
}
