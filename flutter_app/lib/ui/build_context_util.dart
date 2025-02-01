import 'package:flutter/material.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/theme/theme.dart';

extension Adaptive on BuildContext {
  bool get isCupertino => Breakpoint.isCupertino(this);

  TextTheme get textTheme {
    if (isCupertino) return AppTheme.cupertinoTextTheme;
    return AppTheme.materialTextTheme;
  }
}
