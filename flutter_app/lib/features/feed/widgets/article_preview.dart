import 'package:flutter/material.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticlePreview extends StatelessWidget {
  const ArticlePreview({required this.summary, super.key});

  final Summary summary;

  ({double height, double width}) _imageSize(BuildContext context) {
    final breakpoint = BreakpointProvider.of(context);
    final appWidth = BreakpointProvider.appWidth(context);

    return switch (breakpoint.width) {
      BreakpointWidth.small => (height: 160, width: appWidth),
      BreakpointWidth.medium => (
        height: 200,
        width: BreakpointWidth.medium.begin,
      ),
      BreakpointWidth.large => (
        height: 200,
        width: BreakpointWidth.medium.begin,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = summary.originalImage != null;
    final Breakpoint breakpoint = BreakpointProvider.of(context);
    final imageSize = _imageSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (hasImage)
          RoundedImage(
            source: summary.originalImage!.source,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radius),
              topRight: Radius.circular(AppDimensions.radius),
            ),
            height: 160,
            width: imageSize.width,
          ),
        Padding(
          padding: EdgeInsets.all(breakpoint.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: <Widget>[
              if (summary.description != null)
                Text(summary.description!, style: context.labelSmall),
              Text(
                summary.extract,
                style: context.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border_outlined,
                  color: AppColors.primary,
                  size: AppDimensions.iconSize,
                ),
                label: Text(
                  AppStrings.saveForLater,
                  style: context.labelSmall.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
