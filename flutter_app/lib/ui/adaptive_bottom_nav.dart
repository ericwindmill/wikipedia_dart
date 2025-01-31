import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util.dart';

class AdaptiveBottomNav extends StatefulWidget {
  const AdaptiveBottomNav({
    required this.onSelection,
    required this.navigationItems,
    super.key,
  });

  final ValueChanged<int> onSelection;
  final Map<String, Icon> navigationItems;

  @override
  State<AdaptiveBottomNav> createState() => _AdaptiveBottomNavState();
}

class _AdaptiveBottomNavState extends State<AdaptiveBottomNav> {
  int selectedIndex = 0;

  void onSelection(int index) {
    setState(() => selectedIndex = index);
    widget.onSelection(index);
  }

  @override
  Widget build(BuildContext context) {
    return context.isCupertino
        ? CupertinoTabBar(
          currentIndex: selectedIndex,
          onTap: onSelection,
          items:
              widget.navigationItems.entries
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
              widget.navigationItems.entries
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
