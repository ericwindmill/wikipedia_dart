import 'package:flutter/material.dart';
import 'package:flutter_app/features/random_article/random_article_view_model.dart';

import '../ui/shared_widgets/article_summary.dart';

class RandomArticleView extends StatelessWidget {
  const RandomArticleView({super.key, required this.viewModel});

  final RandomArticleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.hasError) {
          return Center(child: Text(viewModel.error!));
        }
        if (!viewModel.hasData && !viewModel.hasError) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        return Scaffold(
          body: ArticleSummary(summary: viewModel.articleSummary),
        );
      },
    );
  }
}
