import 'package:flutter/material.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_app_bar.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_scaffold.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({required this.summary, super.key});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: AppStrings.wikipediaDart),
      body: ListView(
        children: [
          if (summary.originalImage != null)
            RoundedImage(
              source: summary.originalImage!.source,
              height: 200,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.zero,
            ),
          Text(summary.titles.normalized, style: context.textTheme.titleLarge),
          Text(summary.description ?? '', style: context.textTheme.labelSmall),
          Text(summary.extract),
        ],
      ),
    );
  }
}
