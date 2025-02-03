import 'package:flutter/material.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/build_context_util.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.bottomNavigationBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final breakpoint = BreakpointProvider.of(context);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: context.textTheme),
      child: Scaffold(
        appBar: appBar,
        drawer:
            !context.isCupertino && breakpoint.width == BreakpointWidth.large
                ? const NavigationDrawer(children: [Text('Home')])
                : null,
        body: SafeArea(child: body),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
