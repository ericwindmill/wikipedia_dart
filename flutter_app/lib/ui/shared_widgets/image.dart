import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/dimensions.dart';

class RoundedImage extends StatelessWidget {
  RoundedImage({
    required this.source,
    super.key,
    this.height,
    this.width,
    BorderRadius? borderRadius,
    this.fit = BoxFit.cover,
    // white background accounts for transparent background images
    this.backgroundColor = Colors.white,
  }) : radius = borderRadius ?? BorderRadius.circular(Dimensions.radius);

  final String source;
  final BoxFit fit;
  final double? height;
  final double? width;
  final BorderRadius radius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: ClipRRect(
        borderRadius: radius,
        child: Image.network(source, height: height, width: width, fit: fit),
      ),
    );
  }
}
