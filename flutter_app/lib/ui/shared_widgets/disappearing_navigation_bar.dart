import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBarTransition extends StatefulWidget {
  const BottomBarTransition({
    required this.animation,
    required this.backgroundColor,
    required this.child,
    super.key,
  });

  final Animation<double> animation;
  final Color backgroundColor;
  final Widget child;

  @override
  State<BottomBarTransition> createState() => _BottomBarTransition();
}

class _BottomBarTransition extends State<BottomBarTransition> {
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(OffsetAnimation(parent: widget.animation));

  late final Animation<double> heightAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: heightAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class BarAnimation extends ReverseAnimation {
  BarAnimation({required AnimationController parent})
    : super(
        CurvedAnimation(
          parent: parent,
          curve: const Interval(0, 1 / 5),
          reverseCurve: const Interval(1 / 5, 4 / 5),
        ),
      );
}

class OffsetAnimation extends CurvedAnimation {
  OffsetAnimation({required super.parent})
    : super(
        curve: const Interval(
          2 / 5,
          3 / 5,
          curve: Curves.easeInOutCubicEmphasized,
        ),
        reverseCurve: Interval(
          4 / 5,
          1,
          curve: Curves.easeInOutCubicEmphasized.flipped,
        ),
      );
}

class RailAnimation extends CurvedAnimation {
  RailAnimation({required super.parent})
    : super(
        curve: const Interval(0 / 5, 4 / 5),
        reverseCurve: const Interval(3 / 5, 1),
      );
}

class RailFabAnimation extends CurvedAnimation {
  RailFabAnimation({required super.parent})
    : super(curve: const Interval(3 / 5, 1));
}

class ScaleAnimation extends CurvedAnimation {
  ScaleAnimation({required super.parent})
    : super(
        curve: const Interval(
          3 / 5,
          4 / 5,
          curve: Curves.easeInOutCubicEmphasized,
        ),
        reverseCurve: Interval(
          3 / 5,
          1,
          curve: Curves.easeInOutCubicEmphasized.flipped,
        ),
      );
}

class ShapeAnimation extends CurvedAnimation {
  ShapeAnimation({required super.parent})
    : super(
        curve: const Interval(
          2 / 5,
          3 / 5,
          curve: Curves.easeInOutCubicEmphasized,
        ),
      );
}

class SizeAnimation extends CurvedAnimation {
  SizeAnimation({required super.parent})
    : super(
        curve: const Interval(
          0 / 5,
          3 / 5,
          curve: Curves.easeInOutCubicEmphasized,
        ),
        reverseCurve: Interval(
          2 / 5,
          1,
          curve: Curves.easeInOutCubicEmphasized.flipped,
        ),
      );
}

// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class NavRailTransition extends StatefulWidget {
  const NavRailTransition({
    required this.animation,
    required this.backgroundColor,
    required this.child,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;

  @override
  State<NavRailTransition> createState() => _NavRailTransitionState();
}

class _NavRailTransitionState extends State<NavRailTransition> {
  // The animations are only rebuilt by this method when the text
  // direction changes because this widget only depends on Directionality.
  late final bool ltr = Directionality.of(context) == TextDirection.ltr;
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: ltr ? const Offset(-1, 0) : const Offset(1, 0),
    end: Offset.zero,
  ).animate(OffsetAnimation(parent: widget.animation));
  late final Animation<double> widthAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: AnimatedBuilder(
          animation: widthAnimation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.topLeft,
              widthFactor: widthAnimation.value,
              child: FractionalTranslation(
                translation: offsetAnimation.value,
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}
