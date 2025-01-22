import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Convenience class that provides screen-width breakpoints and
/// based on Material 3 design spec. Also provides platform.
///
/// This is a simplified version of the same class in the
/// Flutter Adaptive Scaffold package, made by the Flutter team.
/// https://pub.dev/packages/flutter_adaptive_scaffold
class Breakpoint {
  final TargetPlatform platform;
  final double beginWidth;
  final double endWidth;
  final double padding;

  Breakpoint({
    required this.platform,
    required this.beginWidth,
    required this.endWidth,
    required this.padding,
  });

  const Breakpoint.small({required this.platform})
    : beginWidth = 0,
      endWidth = 600,
      padding = 4;

  const Breakpoint.medium({required this.platform})
    : beginWidth = 600,
      endWidth = 840,
      padding = 8;

  const Breakpoint.large({required this.platform})
    : beginWidth = 1200,
      endWidth = 1600,
      padding = 16;

  /// A set of [TargetPlatform]s that the [Breakpoint] will be active on desktop.
  static const Set<TargetPlatform> desktop = <TargetPlatform>{
    TargetPlatform.linux,
    TargetPlatform.macOS,
    TargetPlatform.windows,
  };

  /// A set of [TargetPlatform]s that the [Breakpoint] will be active on mobile.
  static const Set<TargetPlatform> mobile = <TargetPlatform>{
    TargetPlatform.android,
    TargetPlatform.fuchsia,
    TargetPlatform.iOS,
  };

  /// Returns true if the current platform is Desktop.
  /// On web, returns true if the browser is running on a Desktop OS.
  static isDesktop(BuildContext context) {
    return desktop.contains(Theme.of(context).platform);
  }

  /// Returns true if the current platform is Mobile.
  /// On web, returns true if the browser is running on a Mobile OS.
  static bool isMobile(BuildContext context) {
    return mobile.contains(Theme.of(context).platform);
  }

  final bool isWeb = kIsWeb || kIsWasm;
}
