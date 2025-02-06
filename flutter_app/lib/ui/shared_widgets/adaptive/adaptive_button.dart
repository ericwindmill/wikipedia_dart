import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/build_context_util.dart';

class AdaptiveTextButton extends StatelessWidget {
  const AdaptiveTextButton({required this.child, this.onPressed, super.key});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (context.isCupertino) {
      return CupertinoButton(onPressed: onPressed, child: child);
    } else {
      return TextButton(onPressed: onPressed, child: child);
    }
  }
}
