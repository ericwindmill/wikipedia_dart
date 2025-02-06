import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/cupertino_side_nav.dart';
import 'package:flutter_app/ui/theme/theme.dart';

class AdaptiveTabScaffold extends StatefulWidget {
  const AdaptiveTabScaffold({
    required this.tabs,
    this.title,
    this.navigationItems,
    this.actions = const [],
    this.onSelectIndex,
    this.initialSelectedIndex = 0,
    this.scaffoldBackgroundColor,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  final Widget? title;
  final List<Widget> tabs;
  final Map<String, IconData>? navigationItems;
  final List<Widget> actions;
  final ValueChanged<int>? onSelectIndex;
  final Color? scaffoldBackgroundColor;
  final int initialSelectedIndex;
  final bool automaticallyImplyLeading;

  @override
  State<AdaptiveTabScaffold> createState() => _AdaptiveTabScaffoldState();
}

class _AdaptiveTabScaffoldState extends State<AdaptiveTabScaffold> {
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

    if (context.isCupertino && breakpoint.width == BreakpointWidth.small) {
      return CupertinoTabScaffold(
        backgroundColor: scaffoldColor,
        tabBar: CupertinoTabBar(
          currentIndex: _selectedIndex,
          onTap: onSelectIndex,
          items:
              widget.navigationItems!.entries
                  .map<BottomNavigationBarItem>(
                    (entry) => BottomNavigationBarItem(
                      icon: Icon(entry.value),
                      label: entry.key,
                    ),
                  )
                  .toList(),
        ),
        tabBuilder:
            (context, index) => SafeArea(
              child: Column(
                children: [
                  CupertinoNavigationBar(
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
                  ),

                  Expanded(child: widget.tabs[_selectedIndex]),
                ],
              ),
            ),
      );
    } else if (context.isCupertino &&
        breakpoint.width != BreakpointWidth.small) {
      return CupertinoPageScaffold(
        backgroundColor: scaffoldColor,
        child: SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (breakpoint.width != BreakpointWidth.small &&
                  widget.navigationItems != null)
                CupertinoSideNav(
                  title: widget.title ?? Container(),
                  leading: Row(children: widget.actions),
                  navigationItems: widget.navigationItems!,
                  extended: breakpoint.width == BreakpointWidth.large,
                  onDestinationSelected: onSelectIndex,
                  selectedIndex: _selectedIndex,
                  selectedIndicatorColor: AppColors.flutterBlue1,
                  backgroundColor: Colors.white,
                ),
              Flexible(
                child: Column(
                  children: [
                    Flexible(child: widget.tabs[_selectedIndex]),
                    if (breakpoint.width == BreakpointWidth.small &&
                        widget.navigationItems != null)
                      CupertinoTabBar(
                        currentIndex: _selectedIndex,
                        onTap: onSelectIndex,
                        items:
                            widget.navigationItems!.entries
                                .map<BottomNavigationBarItem>(
                                  (entry) => BottomNavigationBarItem(
                                    icon: Icon(entry.value),
                                    label: entry.key,
                                  ),
                                )
                                .toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar:
          breakpoint.width == BreakpointWidth.small
              ? AppBar(title: widget.title ?? Container())
              : null,
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
            Expanded(child: widget.tabs[_selectedIndex]),
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
