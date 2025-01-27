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
  }) : radius = borderRadius ?? BorderRadius.circular(Dimensions.radius);

  final String source;
  final BoxFit fit;
  final double? height;
  final double? width;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Image.network(source, height: height, width: width, fit: fit),
    );
  }
}
