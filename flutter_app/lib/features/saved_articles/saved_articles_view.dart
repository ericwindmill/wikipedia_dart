import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';

class SavedArticlesView extends StatelessWidget {
  const SavedArticlesView({required this.viewModel, super.key});

  final SavedArticlesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, snapshot) {
        if (viewModel.savedArticles.isEmpty) {
          return Center(
            child: Text('No saved articles', style: context.labelSmall),
          );
        }

        return ListView.separated(
          itemCount: viewModel.savedArticles.length,
          separatorBuilder: (context, index) {
            return const Divider(thickness: .1, height: .1);
          },
          itemBuilder: (context, index) {
            final summary =
                viewModel.savedArticles.entries.elementAt(index).value;
            final trailing =
                summary.hasImage
                    ? RoundedImage(
                      source: summary.preferredSource!,
                      height: 30,
                      width: 30,
                    )
                    : null;

            return context.isCupertino
                ? CupertinoListTile(
                  backgroundColor: Colors.white,
                  title: Text(summary.titles.normalized),
                  subtitle: Text(summary.description ?? ''),
                  trailing: trailing,
                  onTap: () {},
                )
                : ListTile(
                  title: Text(summary.titles.normalized),
                  subtitle: Text(summary.description ?? ''),
                  trailing: trailing,
                  onTap: () {},
                );
          },
        );
      },
    );
  }
}
