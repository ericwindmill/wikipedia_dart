import 'dart:math';

import 'package:flutter/material.dart';

import '../../theme/breakpoint.dart';
import '../../theme/theme.dart';
import 'timeline.dart';

class TimelinePainter extends CustomPainter {
  TimelinePainter({this.dotRadius = 4});
  final double dotRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    const double dotLocation = 10.0;

    const Offset topLineStart = Offset(0, 0);
    final Offset topLineEnd = Offset(
      0,
      dotLocation - dotRadius,
    );
    const Offset dotOffset = Offset(0, dotLocation);
    final Offset bottomLineStart = Offset(
      0,
      dotLocation + dotRadius,
    );
    final Offset bottomLineEnd = Offset(0, size.height);
    canvas.drawLine(topLineStart, topLineEnd, paint);
    canvas.drawCircle(dotOffset, dotRadius, paint);
    canvas.drawLine(bottomLineStart, bottomLineEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      false;
}

enum CapPosition { top, bottom }

class TimelineCap extends StatelessWidget {
  const TimelineCap({
    super.key,
    this.position = CapPosition.top,
  });

  final CapPosition position;
  @override
  Widget build(BuildContext context) {
    final double width = BreakpointProvider.appWidth(
      context,
    );
    final double height =
        BreakpointProvider.of(context).spacing * 6;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: sidebarWidth / 2,
          child: CustomPaint(
            painter: TimelineCapPainter(
              height: height,
              capPosition: position,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(height: height, width: sidebarWidth),
            SizedBox(width: width - sidebarWidth),
          ],
        ),
      ],
    );
  }
}

class TimelineCapPainter extends CustomPainter {
  TimelineCapPainter({
    this.height = 8,
    this.capPosition = CapPosition.top,
  });

  final double height;
  final CapPosition capPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth =
              capPosition == CapPosition.top ? 0.0 : 2.0
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    int i = 0;
    while (i < height) {
      paint.strokeWidth =
          capPosition == CapPosition.top
              ? min(2, paint.strokeWidth + (2 / height))
              : paint.strokeWidth - (2 / height);
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(0, (i + 1).toDouble()),
        paint,
      );
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      false;
}
