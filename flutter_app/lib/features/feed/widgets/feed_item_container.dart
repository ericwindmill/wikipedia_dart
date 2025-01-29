import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/theme/dimensions.dart';

const double feedItemHeaderHeight = 60;

({double feedItemHeight, double feedItemWidth}) itemSize(BuildContext context) {
  final breakpoint = BreakpointProvider.of(context);
  final totalWidth = BreakpointProvider.appWidth(context);

  return switch (breakpoint.width) {
    BreakpointWidth.small => (feedItemHeight: 400, feedItemWidth: totalWidth),
    BreakpointWidth.medium => (
      feedItemHeight: 400,
      // account for spacing between items
      feedItemWidth: (totalWidth - breakpoint.spacing * 2) / 2,
    ),
    BreakpointWidth.large => (
      feedItemHeight: 420,
      feedItemWidth: (totalWidth - breakpoint.spacing * 2) / 3,
    ),
  };
}

class FeedItem extends StatelessWidget {
  const FeedItem({
    required this.child,
    this.onTap,
    this.header,
    this.subhead,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final String? header;
  final String? subhead;

  @override
  Widget build(BuildContext context) {
    final size = itemSize(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size.feedItemHeight,
        width: size.feedItemWidth,
        child: Stack(
          children: [
            if (header != null)
              Positioned(
                top: 0,
                height: feedItemHeaderHeight,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(header!, style: TextTheme.of(context).titleMedium),
                      if (subhead != null)
                        Text(
                          subhead!,
                          style: TextTheme.of(context).labelMedium,
                        ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: feedItemHeaderHeight,
              height: size.feedItemHeight - feedItemHeaderHeight,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 10,
                      color: Colors.black12,
                    ),
                  ],
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
