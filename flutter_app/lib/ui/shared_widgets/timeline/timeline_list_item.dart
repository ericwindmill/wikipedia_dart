import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import '../../theme/breakpoint.dart';
import '../../theme/theme.dart';
import 'timeline.dart';

class TimelineListItem extends StatelessWidget {
  const TimelineListItem({
    required this.event,
    super.key,
    this.showPageLinks = true,
    this.contentPadding = EdgeInsets.zero,
  });

  final OnThisDayEvent event;
  final bool showPageLinks;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    final double width = BreakpointProvider.appWidth(
      context,
    );
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: sidebarWidth / 2,
          child: CustomPaint(painter: TimelinePainter()),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(width: sidebarWidth),
                SizedBox(
                  width: width - sidebarWidth,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event.type != EventType.holiday
                            ? event.year!.absYear
                            : event.type.humanReadable,
                        style: AppTheme.timelineEntryTitle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Text(
                          event.text,
                          style:
                              TextTheme.of(
                                context,
                              ).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showPageLinks)
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: event.pages.length + 1,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    if (index == 0) {
                      return Container(width: sidebarWidth);
                    }
                    return TimelinePageLink(
                      event.pages[index - 1],
                    );
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
