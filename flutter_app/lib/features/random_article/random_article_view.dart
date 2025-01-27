import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({required this.summary, super.key});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(summary.titles.normalized)),
    );
  }
}
