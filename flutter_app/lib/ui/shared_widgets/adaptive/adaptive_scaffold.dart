import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/app_localization.dart';
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

    if (context.isCupertino) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar.large(
          largeTitle: Text(AppStrings.wikipediaDart),
        ),
        child: SafeArea(child: body),
      );
    }

    return Scaffold(
      appBar: appBar,
      drawer:
          !context.isCupertino && breakpoint.width == BreakpointWidth.large
              ? const NavigationDrawer(children: [Text('Home')])
              : null,
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
