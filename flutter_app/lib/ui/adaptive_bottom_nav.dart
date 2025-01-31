import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/breakpoint.dart';

class AdaptiveBottomNav extends StatefulWidget {
  const AdaptiveBottomNav({required this.onSelection, super.key});

  final ValueChanged<int> onSelection;

  @override
  State<AdaptiveBottomNav> createState() => _AdaptiveBottomNavState();
}

class _AdaptiveBottomNavState extends State<AdaptiveBottomNav> {
  int selectedIndex = 0;

  Map<String, Icon> get _navigationItems => {
    'Explore':
        Breakpoint.isCupertino(context)
            ? const Icon(CupertinoIcons.house_fill)
            : const Icon(Icons.home),
    'Timeline':
        Breakpoint.isCupertino(context)
            ? const Icon(CupertinoIcons.calendar)
            : const Icon(Icons.calendar_month),
    'Saved for Later':
        (Platform.isIOS || Platform.isMacOS)
            ? const Icon(CupertinoIcons.bookmark)
            : const Icon(Icons.bookmark_border),
  };

  void onSelection(int index) {
    setState(() => selectedIndex = index);
    widget.onSelection(index);
  }

  @override
  Widget build(BuildContext context) {
    return Breakpoint.isCupertino(context)
        ? CupertinoTabBar(
          currentIndex: selectedIndex,
          onTap: onSelection,
          items:
              _navigationItems.entries
                  .map<BottomNavigationBarItem>(
                    (entry) => BottomNavigationBarItem(
                      icon: entry.value,
                      label: entry.key,
                    ),
                  )
                  .toList(),
        )
        : NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onSelection,
          destinations:
              _navigationItems.entries
                  .map<Widget>(
                    (entry) => NavigationDestination(
                      icon: entry.value,
                      label: entry.key,
                    ),
                  )
                  .toList(),
        );
  }
}
