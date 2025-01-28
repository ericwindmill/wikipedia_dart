import 'package:flutter/material.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ImageModalView extends StatelessWidget {
  const ImageModalView(
    this.image, {
    super.key,
    this.title,
    this.attribution,
    this.description,
  });

  final WikipediaImage image;
  Color get foregroundColor => Colors.white;
  final String? title;
  final String? attribution;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(
      context,
    ).textTheme.bodyMedium!.copyWith(color: Colors.white);
    return Dismissible(
      direction: DismissDirection.vertical,
      onDismissed: Navigator.of(context).pop,
      key: const Key('ImageModal'),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: RoundedImage(
                source: image.originalImage.source,
                borderRadius: BorderRadius.zero,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(BreakpointProvider.of(context).padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: BreakpointProvider.of(context).spacing * 2,
                  children: <Widget>[
                    const Center(
                      child: Icon(Icons.drag_handle, color: Colors.white),
                    ),
                    if (title != null) Text(title!, style: textStyle),
                    if (description != null)
                      Text(description!, style: textStyle),
                    if (attribution != null)
                      Text(attribution!, style: textStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
