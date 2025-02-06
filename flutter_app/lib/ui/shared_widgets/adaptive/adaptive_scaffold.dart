import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/theme/theme.dart';

class AdaptivePageScaffold extends StatefulWidget {
  const AdaptivePageScaffold({
    required this.body,
    this.title,
    this.navigationItems,
    this.actions = const [],
    this.onSelectIndex,
    this.initialSelectedIndex = 0,
    this.scaffoldBackgroundColor,
    this.automaticallyImplyLeading = true,
    this.showAppBar = false,
    super.key,
  });

  final Widget? title;
  final Widget body;
  final Map<String, IconData>? navigationItems;
  final List<Widget> actions;
  final ValueChanged<int>? onSelectIndex;
  final Color? scaffoldBackgroundColor;
  final int initialSelectedIndex;
  final bool automaticallyImplyLeading;
  final bool showAppBar;

  @override
  State<AdaptivePageScaffold> createState() => _AdaptivePageScaffoldState();
}

class _AdaptivePageScaffoldState extends State<AdaptivePageScaffold> {
  @override
  void initState() {
    _selectedIndex = widget.initialSelectedIndex;
    super.initState();
  }

  late int _selectedIndex;

  void onSelectIndex(int index) {
    setState(() {
      _selectedIndex = index;
      if (widget.onSelectIndex != null) {
        widget.onSelectIndex!.call(index);
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = BreakpointProvider.of(context);
    final scaffoldColor =
        widget.scaffoldBackgroundColor ??
        (context.isCupertino
            ? CupertinoTheme.of(context).scaffoldBackgroundColor
            : Theme.of(context).scaffoldBackgroundColor);

    if (context.isCupertino) {
      return CupertinoPageScaffold(
        backgroundColor: scaffoldColor,
        navigationBar:
            widget.showAppBar
                ? CupertinoNavigationBar(
                  leading:
                      !widget.automaticallyImplyLeading
                          ? Align(
                            alignment: Alignment.centerLeft,
                            child: widget.title ?? Container(),
                          )
                          : null,
                  automaticallyImplyLeading: widget.automaticallyImplyLeading,
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.actions,
                  ),
                )
                : null,
        child: SafeArea(child: widget.body),
      );
    }

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar:
          widget.showAppBar ? AppBar(title: widget.title ?? Container()) : null,
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (breakpoint.width != BreakpointWidth.small &&
                widget.navigationItems != null)
              NavigationRail(
                destinations: [
                  for (final d in widget.navigationItems!.entries)
                    NavigationRailDestination(
                      icon: Icon(d.value),
                      label: Text(d.key),
                    ),
                ],
                selectedIndex: _selectedIndex,
                extended: breakpoint.width == BreakpointWidth.large,
                backgroundColor: AppColors.flutterBlue1,
                indicatorColor: Colors.white,
                onDestinationSelected: onSelectIndex,
              ),
            Expanded(child: widget.body),
          ],
        ),
      ),
      bottomNavigationBar:
          (breakpoint.width == BreakpointWidth.small &&
                  widget.navigationItems != null)
              ? NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: onSelectIndex,
                indicatorColor: AppColors.flutterBlue3,
                destinations:
                    widget.navigationItems!.entries
                        .map<Widget>(
                          (entry) => NavigationDestination(
                            icon: Icon(entry.value),
                            label: entry.key,
                          ),
                        )
                        .toList(),
              )
              : null,
    );
  }
}
