import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum BreakpointWidth {
  small(0, 600),
  medium(600, 840),
  large(840, double.infinity);

  const BreakpointWidth(this.begin, this.end);

  final double begin;
  final double end;
}

/// Convenience class that provides screen-width breakpoints and
/// based on Material 3 design spec. Also provides platform.
///
/// This is a simplified version of the same class in the
/// Flutter Adaptive Scaffold package, made by the Flutter team.
/// https://pub.dev/packages/flutter_adaptive_scaffold
class Breakpoint {
  final TargetPlatform platform;

  final BreakpointWidth width;

  /// Margin for screens and other large views that run against the edges of
  /// of the viewport
  final double margin;

  /// Padding within an element
  final double padding;

  /// Padding between elements, such as two items in a column
  final double spacing;

  Breakpoint({
    required this.platform,
    required this.width,
    required this.margin,
    required this.padding,
    required this.spacing,
  });

  factory Breakpoint.currentDevice(
    BuildContext context,
  ) => switch (MediaQuery.of(context).size.width) {
    >= 0 && < 600 => Breakpoint.small(platform: Theme.of(context).platform),
    >= 600 && < 840 => Breakpoint.medium(platform: Theme.of(context).platform),
    _ => Breakpoint.large(platform: Theme.of(context).platform),
  };

  const Breakpoint.small({required this.platform})
    : width = BreakpointWidth.small,
      margin = 16,
      spacing = 4,
      padding = 8;

  const Breakpoint.medium({required this.platform})
    : width = BreakpointWidth.medium,
      margin = 24,
      spacing = 16,
      padding = 8;

  const Breakpoint.large({required this.platform})
    : width = BreakpointWidth.large,
      margin = 24,
      spacing = 24,
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
  static bool isDesktop(BuildContext context) {
    return desktop.contains(Theme.of(context).platform);
  }

  /// Returns true if the current platform is Mobile.
  /// On web, returns true if the browser is running on a Mobile OS.
  static bool isMobile(BuildContext context) {
    return mobile.contains(Theme.of(context).platform);
  }

  static bool isWeb = kIsWeb || kIsWasm;
}

class BreakpointProvider extends InheritedWidget {
  const BreakpointProvider({
    super.key,
    required super.child,
    required this.breakpoint,
  });

  final Breakpoint breakpoint;

  static Breakpoint of(BuildContext context) {
    final BreakpointProvider? result =
        context.dependOnInheritedWidgetOfExactType<BreakpointProvider>();
    assert(result != null, 'No BreakpointProvider found in context');
    return result!.breakpoint;
  }

  /// Returns the width of app content, accounting for margins
  static double appWidth(BuildContext context) {
    var breakpoint = of(context);
    return MediaQuery.of(context).size.width - (breakpoint.margin * 2);
  }

  @override
  bool updateShouldNotify(BreakpointProvider old) {
    return old.breakpoint != breakpoint;
  }
}

class BreakpointAwareWidget extends StatefulWidget {
  const BreakpointAwareWidget({
    super.key,
    required this.child,
    Widget? mdChild,
    Widget? lgChild,
  }) : mediumChild = mdChild ?? child,
       largeChild = lgChild ?? mdChild ?? child;

  final Widget child;
  final Widget mediumChild;
  final Widget largeChild;

  @override
  State<BreakpointAwareWidget> createState() => _BreakpointAwareLayoutState();
}

class _BreakpointAwareLayoutState extends State<BreakpointAwareWidget> {
  late Breakpoint breakpoint;

  @override
  void initState() {
    breakpoint = BreakpointProvider.of(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    breakpoint = BreakpointProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return switch (breakpoint.width) {
          BreakpointWidth.small => widget.child,
          BreakpointWidth.medium => widget.mediumChild,
          BreakpointWidth.large => widget.largeChild,
        };
      }),
    );
  }
}
