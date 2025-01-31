import 'package:flutter/material.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';

class SavedArticlesPageView extends StatelessWidget {
  const SavedArticlesPageView({required this.viewModel, super.key});

  final SavedArticlesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [Text('Article!')]);
  }
}
