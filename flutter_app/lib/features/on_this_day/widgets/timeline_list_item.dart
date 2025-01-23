import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import '../../ui/theme.dart';
import '../timeline_view.dart';
import 'event_info.dart';
import '../../ui/shared_widgets/wiki_page_link.dart';

class TimelineListItem extends StatelessWidget {
  const TimelineListItem({super.key, required this.event});

  final OnThisDayEvent event;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: width * sidebarWidthPercentage / 2,
          child: _VerticalTimeline(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: width * sidebarWidthPercentage),
                  SizedBox(
                    width: width * mainColumnWidthPercentage,
                    child: EventInfo(event),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: event.pages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(width: width * sidebarWidthPercentage);
                    }
                    return WikiPageDisplay(event.pages[index - 1]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VerticalTimeline extends StatelessWidget {
  const _VerticalTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: TimelinePainter());
  }
}

class TimelinePainter extends CustomPainter {
  TimelinePainter({this.dotRadius = 4, this.xOffset = 0});

  final double xOffset;
  final double dotRadius;

  @override
  void paint(Canvas canvas, Size size) {
    var paint =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    final dotLocation = 10.0;

    var topLineStart = Offset(xOffset, 0);
    var topLineEnd = Offset(xOffset, dotLocation - dotRadius);
    var dotOffset = Offset(xOffset, dotLocation);
    var bottomLineStart = Offset(xOffset, dotLocation + dotRadius);
    var bottomLineEnd = Offset(xOffset, size.height);
    canvas.drawLine(topLineStart, topLineEnd, paint);
    canvas.drawCircle(dotOffset, dotRadius, paint);
    canvas.drawLine(bottomLineStart, bottomLineEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
