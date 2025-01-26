import 'package:flutter/foundation.dart';
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('source', source))
      ..add(EnumProperty<BoxFit>('fit', fit))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty<BorderRadius>('radius', radius));
  }
}
