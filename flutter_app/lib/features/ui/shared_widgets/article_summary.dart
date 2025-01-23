import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticleSummary extends StatelessWidget {
  const ArticleSummary({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [Text(summary.extract)],
    );
  }
}

class Box extends StatelessWidget {
  const Box({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(),
      ),
      child: Column(
        children: [
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.titleSmall),
          child,
        ],
      ),
    );
  }
}
