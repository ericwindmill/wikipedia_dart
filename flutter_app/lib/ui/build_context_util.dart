import 'package:flutter/material.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/theme/theme.dart';

extension Adaptive on BuildContext {
  // TODO(ewindmill): This is currently backwards, purposefully
  bool get isCupertino => !Breakpoint.isCupertino(this);

  TextTheme get textTheme {
    if (isCupertino) return AppTheme.cupertinoTextTheme;
    return AppTheme.materialTextTheme;
  }

  ThemeData get themeData {
    if (isCupertino) return AppTheme.cupertinoLightTheme;
    return AppTheme.materialLightTheme;
  }
}
