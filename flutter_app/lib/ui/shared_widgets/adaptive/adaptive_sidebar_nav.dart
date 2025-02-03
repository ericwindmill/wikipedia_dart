import 'package:flutter/material.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/build_context_util.dart';

class AdaptiveSidebarNav extends StatefulWidget {
  const AdaptiveSidebarNav({super.key});

  @override
  State<AdaptiveSidebarNav> createState() => _AdaptiveSidebarNavState();
}

class _AdaptiveSidebarNavState extends State<AdaptiveSidebarNav> {
  @override
  void didChangeDependencies() {
    final breakpoint = BreakpointProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (context.isCupertino) {
      return const Placeholder();
    } else {
      return NavigationRail(destinations: const [], selectedIndex: 0);
    }
  }
}
