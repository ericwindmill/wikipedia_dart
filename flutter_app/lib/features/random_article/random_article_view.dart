import 'package:flutter/material.dart';
import 'random_article_view_model.dart';

class RandomArticleView extends StatelessWidget {
  const RandomArticleView({
    required this.viewModel,
    super.key,
  });

  final RandomArticleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, _) {
        if (viewModel.hasError) {
          return Center(child: Text(viewModel.error));
        }
        if (!viewModel.hasData && !viewModel.hasError) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return const Scaffold();
      },
    );
  }
}
