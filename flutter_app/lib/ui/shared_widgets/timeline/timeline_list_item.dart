import 'package:flutter/material.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:flutter_app/util.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelineListItem extends StatelessWidget {
  const TimelineListItem({
    required this.event,
    super.key,
    this.showPageLinks = true,
    this.contentPadding = EdgeInsets.zero,
    this.maxLines,
  });

  final OnThisDayEvent event;
  final bool showPageLinks;
  final EdgeInsets contentPadding;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: sidebarWidth / 2,
          child: CustomPaint(painter: TimelinePainter()),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: sidebarWidth),
                child: Text(
                  event.type != EventType.holiday
                      ? event.year!.absYear
                      : event.type.humanReadable,
                  style: AppTheme.timelineEntryTitle,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: BreakpointProvider.of(context).spacing,
                  left: sidebarWidth,
                  right: BreakpointProvider.of(context).padding,
                ),
                child: Text(
                  event.text,
                  style: context.textTheme.bodyMedium,
                  maxLines: maxLines,
                  overflow: (maxLines != null) ? TextOverflow.ellipsis : null,
                ),
              ),
            ),
            if (showPageLinks)
              SizedBox(
                height: 65,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: event.pages.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(width: sidebarWidth);
                    }
                    return TimelinePageLink(event.pages[index - 1]);
                  },
                ),
              ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}
