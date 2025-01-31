import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util.dart';

class AdaptiveTextButton extends StatelessWidget {
  const AdaptiveTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    const child = Text('Button');

    return context.isCupertino
        ? CupertinoButton(child: child, onPressed: () {})
        : TextButton(child: child, onPressed: () {});
  }
}
