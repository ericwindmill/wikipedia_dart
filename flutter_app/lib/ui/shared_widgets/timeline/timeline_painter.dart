import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_app/ui/theme/theme.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline.dart';

class TimelinePainter extends CustomPainter {
  TimelinePainter({this.dotRadius = 4});
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

    var topLineStart = Offset(0, 0);
    var topLineEnd = Offset(0, dotLocation - dotRadius);
    var dotOffset = Offset(0, dotLocation);
    var bottomLineStart = Offset(0, dotLocation + dotRadius);
    var bottomLineEnd = Offset(0, size.height);
    canvas.drawLine(topLineStart, topLineEnd, paint);
    canvas.drawCircle(dotOffset, dotRadius, paint);
    canvas.drawLine(bottomLineStart, bottomLineEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum CapPosition { top, bottom }

class TimelineCap extends StatelessWidget {
  const TimelineCap({super.key, this.position = CapPosition.top});

  final CapPosition position;
  @override
  Widget build(BuildContext context) {
    final width = BreakpointProvider.appWidth(context);
    final height = BreakpointProvider.of(context).spacing * 6;
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: sidebarWidth / 2,
          child: CustomPaint(
            painter: TimelineCapPainter(height: height, capPosition: position),
          ),
        ),
        Row(
          children: [
            SizedBox(height: height, width: sidebarWidth),
            SizedBox(width: width - sidebarWidth),
          ],
        ),
      ],
    );
  }
}

class TimelineCapPainter extends CustomPainter {
  TimelineCapPainter({this.height = 8, this.capPosition = CapPosition.top});

  final double height;
  final CapPosition capPosition;

  @override
  void paint(Canvas canvas, Size size) {
    var paint =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = capPosition == CapPosition.top ? 0.0 : 2.0
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    var i = 0;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
