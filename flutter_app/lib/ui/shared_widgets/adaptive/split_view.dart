import 'package:flutter/material.dart';

class SplitView extends StatelessWidget {
  const SplitView({required this.left, required this.right, super.key});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 2, child: left),
        Flexible(flex: 3, child: right),
      ],
    );
  }
}
