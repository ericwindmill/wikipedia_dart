import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticleSummary extends StatelessWidget {
  const ArticleSummary({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [Text(summary.titles.normalized)],
    );
  }
}
