import 'package:flutter/material.dart';
import 'package:flutter_app/ui/breakpoint.dart';

class BreakpointProvider extends InheritedWidget {
  const BreakpointProvider({
    required super.child,
    required this.breakpoint,
    super.key,
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
    final Breakpoint breakpoint = of(context);
    return MediaQuery.of(context).size.width - (breakpoint.margin * 2);
  }

  @override
  bool updateShouldNotify(BreakpointProvider old) {
    return old.breakpoint != breakpoint;
  }
}

class BreakpointAwareWidget extends StatefulWidget {
  const BreakpointAwareWidget({
    required this.smChild,
    super.key,
    Widget? mdChild,
    Widget? lgChild,
  }) : mediumChild = mdChild ?? smChild,
       largeChild = lgChild ?? mdChild ?? smChild;

  final Widget smChild;
  final Widget mediumChild;
  final Widget largeChild;

  @override
  State<BreakpointAwareWidget> createState() => _BreakpointAwareLayoutState();
}

class _BreakpointAwareLayoutState extends State<BreakpointAwareWidget> {
  late Breakpoint breakpoint;

  @override
  void didChangeDependencies() {
    breakpoint = BreakpointProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return switch (breakpoint.width) {
          BreakpointWidth.small => widget.smChild,
          BreakpointWidth.medium => widget.mediumChild,
          BreakpointWidth.large => widget.largeChild,
        };
      },
    );
  }
}
