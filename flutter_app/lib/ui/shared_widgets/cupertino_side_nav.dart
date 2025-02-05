import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/theme/theme.dart';

const double collapsedWidth = 72;
const double extendedWidth = 256;

class CupertinoSideNav extends StatefulWidget {
  const CupertinoSideNav({
    required this.title,
    required this.navigationItems,
    required this.selectedIndex,
    this.onDestinationSelected,
    this.extended = true,
    this.backgroundColor,
    this.elevation = 0.0,
    this.unselectedIconTheme,
    this.selectedIconTheme,
    this.selectedIndicatorColor,
    super.key,
  }) : assert(
         selectedIndex == null ||
             (0 <= selectedIndex && selectedIndex < navigationItems.length),
         'Selected index must be an int between 0 and navigationItems.length',
       ),
       assert(elevation >= 0, 'Elevation cannot be negative');

  final Widget title;
  final Map<String, IconData> navigationItems;
  final int? selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final bool extended;
  final Color? backgroundColor;
  final double elevation;
  final IconThemeData? unselectedIconTheme;
  final IconThemeData? selectedIconTheme;
  final Color? selectedIndicatorColor;

  @override
  State<CupertinoSideNav> createState() => _CupertinoSideNavState();
}

class _CupertinoSideNavState extends State<CupertinoSideNav> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.surface;
    final indicatorColor =
        widget.selectedIndicatorColor ?? Theme.of(context).colorScheme.primary;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: collapsedWidth,
        maxWidth: extendedWidth,
      ),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(padding: const EdgeInsets.all(16.0), child: widget.title),
            const SizedBox(height: 30),
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < widget.navigationItems.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CupertinoRailOption(
                        icon: widget.navigationItems.entries.elementAt(i).value,
                        label: widget.navigationItems.entries.elementAt(i).key,
                        unselectedIconTheme:
                            widget.unselectedIconTheme ??
                            const IconThemeData(
                              color: CupertinoColors.secondaryLabel,
                              opacity: 0.9,
                            ),
                        selectedIconTheme:
                            widget.selectedIconTheme ??
                            IconThemeData(
                              color: Theme.of(context).colorScheme.primary,
                              opacity: 1.0,
                            ),
                        selected: i == widget.selectedIndex,
                        indicatorColor: indicatorColor,
                        backgroundColor: backgroundColor,
                        onTap: () {
                          if (widget.onDestinationSelected != null) {
                            widget.onDestinationSelected!(i);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoRailOption extends StatefulWidget {
  const CupertinoRailOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.unselectedIconTheme,
    required this.selectedIconTheme,
    required this.onTap,
    required this.backgroundColor,
    required this.indicatorColor,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool selected;
  final IconThemeData unselectedIconTheme;
  final IconThemeData selectedIconTheme;
  final Color backgroundColor;
  final Color indicatorColor;

  @override
  State<CupertinoRailOption> createState() => _CupertinoRailOptionState();
}

class _CupertinoRailOptionState extends State<CupertinoRailOption> {
  late Color _backgroundColor = _computeBackgroundColor();
  bool hovered = false;

  Color _computeBackgroundColor() {
    return switch ((hovered, widget.selected)) {
      (true, true) => _darken(widget.indicatorColor),
      (true, false) => Colors.black12,
      (false, true) => widget.indicatorColor,
      (false, false) => widget.backgroundColor,
    };
  }

  Color _lighten(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - .1).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color _darken(Color color) {
    final hsl = HSLColor.fromColor(_backgroundColor);
    final hslLight = hsl.withLightness((hsl.lightness + .1).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  @override
  Widget build(BuildContext context) {
    _backgroundColor = _computeBackgroundColor();
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radius),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          });
        },
        child: MouseRegion(
          onEnter: (PointerEnterEvent event) {
            setState(() {
              hovered = true;
            });
          },
          onExit: (PointerExitEvent event) {
            setState(() {
              hovered = false;
            });
          },
          child: ColoredBox(
            color: _backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  IconTheme(
                    data:
                        widget.selected
                            ? widget.selectedIconTheme
                            : widget.unselectedIconTheme,
                    child: Icon(widget.icon),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(widget.label)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
