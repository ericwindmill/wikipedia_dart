import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_view.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_scaffold.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticlePageView extends StatelessWidget {
  const ArticlePageView({required this.summary, super.key});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      scaffoldBackgroundColor: Colors.white,
      showAppBar: true,
      body: ArticleView(summary: summary),
    );
  }
}
