import 'package:flutter/material.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/theme/dimensions.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ArticlePreview extends StatelessWidget {
  const ArticlePreview({required this.summary, super.key});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = summary.originalImage != null;
    const double imageHeight = 140;
    final Breakpoint breakpoint = BreakpointProvider.of(
      context,
    );

    return SizedBox(
      height: hasImage ? 290 : 150,
      child: Padding(
        padding: EdgeInsets.all(breakpoint.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (hasImage)
              RoundedImage(
                source: summary.originalImage!.source,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    Dimensions.radius,
                  ),
                  topRight: Radius.circular(
                    Dimensions.radius,
                  ),
                ),
                height: imageHeight,
                width:
                    MediaQuery.of(context).size.width -
                    breakpoint.margin,
              ),
            Text(
              summary.titles.normalized,
              style: AppTheme.serifTitle,
            ),
            if (summary.description != null)
              Padding(
                padding: EdgeInsets.only(
                  bottom: breakpoint.spacing,
                ),
                child: Text(
                  summary.description!,
                  style: TextTheme.of(context).labelMedium,
                ),
              ),
            const Spacer(),
            Text(
              summary.extract,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_border_outlined,
                color: AppColors.primary,
                size: 16,
              ),
              label: Text(
                'Save for later',
                style: TextTheme.of(context).labelMedium!
                    .copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
