import 'package:flutter/material.dart';
import 'package:flutter_app/features/article_view/article_view_model.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/adaptive_app_bar.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:flutter_app/util.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({required this.viewModel, super.key});

  final ArticleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdaptiveAppBar(title: AppStrings.wikipediaDart),
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
                  vertical: BreakpointProvider.of(context).spacing,
                ),
                child: Text(
                  viewModel.summary.titles.normalized,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: AppTheme.serif.fontFamily,
                    fontFamilyFallback: AppTheme.serif.fontFamilyFallback,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: BreakpointProvider.of(context).margin,
                ),
                padding: EdgeInsets.only(
                  bottom: BreakpointProvider.of(context).spacing,
                ),
                child: Text(
                  viewModel.summary.description ?? '',
                  style: context.textTheme.labelSmall,
                ),
              ),
              ...List<Widget>.generate(viewModel.article.length, (index) {
                final breakpoint = BreakpointProvider.of(context);
                final ArticleElement element = viewModel.article[index];
                final inner = switch (element.type) {
                  ElementType.heading1 => Padding(
                    padding: EdgeInsets.symmetric(vertical: breakpoint.spacing),
                    child: Text(
                      element.body,
                      style: context.textTheme.titleLarge!.copyWith(
                        fontFamily: AppTheme.serif.fontFamily,
                        fontFamilyFallback: AppTheme.serif.fontFamilyFallback,
                      ),
                    ),
                  ),
                  ElementType.heading2 => Padding(
                    padding: EdgeInsets.symmetric(vertical: breakpoint.spacing),
                    child: Text(
                      element.body,
                      style: context.textTheme.titleMedium!.copyWith(
                        fontFamily: AppTheme.serif.fontFamily,
                        fontFamilyFallback: AppTheme.serif.fontFamilyFallback,
                      ),
                    ),
                  ),
                  ElementType.heading3 => Padding(
                    padding: EdgeInsets.symmetric(vertical: breakpoint.spacing),
                    child: Text(
                      element.body,
                      style: context.textTheme.titleSmall!.copyWith(
                        fontFamily: AppTheme.serif.fontFamily,
                        fontFamilyFallback: AppTheme.serif.fontFamilyFallback,
                      ),
                    ),
                  ),
                  ElementType.paragraph => Padding(
                    padding: EdgeInsets.symmetric(vertical: breakpoint.spacing),
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
