import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import '../../ui/breakpoint.dart';
import '../../ui/shared_widgets/image.dart';
import '../../ui/theme.dart';

class ArticlePreview extends StatelessWidget {
  const ArticlePreview({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    bool hasImage = summary.originalImage != null;
    double imageHeight = 140;
    Breakpoint breakpoint = BreakpointProvider.of(context);

    return SizedBox(
      height: hasImage ? 285 : 145,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage)
            RoundedImage(
              source: summary.originalImage!.source,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius),
                topRight: Radius.circular(Dimensions.radius),
              ),
              height: imageHeight,
              width: MediaQuery.of(context).size.width - breakpoint.margin,
            ),
          Text(summary.titles.normalized, style: AppTheme.serifTitle),
          if (summary.description != null)
            Padding(
              padding: EdgeInsets.only(top: breakpoint.spacing, bottom: 8),
              child: Text(
                summary.description!,
                style: TextTheme.of(context).labelMedium,
              ),
            ),
          Text(summary.extract, overflow: TextOverflow.ellipsis, maxLines: 3),
          Spacer(),
          TextButton.icon(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              print('saving');
            },
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: AppColors.primary,
              size: 16,
            ),
            label: Text(
              'Save for later',
              style: TextTheme.of(
                context,
              ).labelMedium!.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
