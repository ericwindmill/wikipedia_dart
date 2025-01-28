import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_view_model.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticleView extends StatelessWidget {
  ArticleView({required Summary summary, super.key})
    : viewModel = ArticleViewModel(summary);

  final ArticleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.wikipediaDart,
          style: AppTheme.serifTitle.copyWith(fontSize: 20),
        ),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, _) {
          // TODO(ewindmill): handle errors
          if (viewModel.hasError) {
            return Center(child: Text(viewModel.error));
          }
          if (!viewModel.hasData && !viewModel.hasError) {
            return const Center(
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          return ListView(
            children: [
              if (viewModel.summary.originalImage != null)
                RoundedImage(
                  source: viewModel.summary.originalImage!.source,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: BorderRadius.zero,
                ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: BreakpointProvider.of(context).margin,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: BreakpointProvider.of(context).spacing * 3,
                ),
                child: Text(
                  viewModel.summary.titles.normalized,
                  style: AppTheme.serifTitle,
                ),
              ),
              ...List<Widget>.generate(viewModel.article.length, (index) {
                final breakpoint = BreakpointProvider.of(context);
                final ArticleElement element = viewModel.article[index];
                final inner = switch (element.type) {
                  ElementType.heading1 => Padding(
                    padding: EdgeInsets.only(
                      top: breakpoint.spacing * 6,
                      bottom: breakpoint.spacing,
                    ),
                    child: Text(element.body, style: AppTheme.serifHeading1),
                  ),
                  ElementType.heading2 => Padding(
                    padding: EdgeInsets.only(
                      top: breakpoint.spacing * 4,
                      bottom: breakpoint.spacing,
                    ),
                    child: Text(element.body, style: AppTheme.serifHeading2),
                  ),
                  ElementType.heading3 => Padding(
                    padding: EdgeInsets.only(
                      top: breakpoint.spacing * 2,
                      bottom: breakpoint.spacing,
                    ),
                    child: Text(element.body, style: AppTheme.serifHeading3),
                  ),
                  ElementType.paragraph => Padding(
                    padding: EdgeInsets.only(
                      top: breakpoint.spacing,
                      bottom: breakpoint.spacing,
                    ),
                    child: Text(element.body),
                  ),
                  ElementType.image => throw UnimplementedError(),
                };
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: BreakpointProvider.of(context).margin,
                  ),
                  child: inner,
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
