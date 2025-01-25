import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';

import 'package:flutter_app/ui/theme/dimensions.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    super.key,
    required this.sectionTitle,
    this.subtitle,
    required this.child,
  });

  final String sectionTitle;
  final Widget child;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sectionTitle, style: TextTheme.of(context).titleMedium),
        if (subtitle != null)
          Text(subtitle!, style: TextTheme.of(context).labelMedium),
        SizedBox(height: BreakpointProvider.of(context).spacing * 2),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(Dimensions.radius),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, .15),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
