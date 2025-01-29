import 'package:flutter/material.dart';
import 'package:flutter_app/ui/shared_widgets/image.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ImageModalView extends StatelessWidget {
  const ImageModalView(
    this.image, {
    required this.file,
    super.key,
    this.title,
    this.attribution,
    this.description,
  });

  final WikipediaImage image;
  final ImageFile file;
  Color get foregroundColor => Colors.white;
  final String? title;
  final String? attribution;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Dismissible(
      direction: DismissDirection.vertical,
      onDismissed: Navigator.of(context).pop,
      key: const Key('ImageModal'),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: RoundedImage(
                borderRadius: BorderRadius.zero,
                source: file.source,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Container(
                  margin: EdgeInsets.all(BreakpointProvider.of(context).margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: BreakpointProvider.of(context).spacing,
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
            ),
          ],
        ),
      ),
    );
  }
}
