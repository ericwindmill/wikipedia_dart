import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/theme.dart';

class RoundedImage extends StatelessWidget {
  RoundedImage({
    required this.source,
    super.key,
    this.height,
    this.width,
    BorderRadius? borderRadius,
    this.fit = BoxFit.cover,
  }) : radius = borderRadius ?? BorderRadius.circular(AppDimensions.radius);

  final String source;
  final BoxFit fit;
  final double? height;
  final double? width;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    // The container adds a background color because some images from
    // wikipedia have a transparent background
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: radius),
      child: ClipRRect(
        borderRadius: radius,
        child: Image.network(source, height: height, width: width, fit: fit),
      ),
    );
  }
}
