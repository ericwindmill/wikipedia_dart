import 'package:flutter/material.dart';

class CupertinoBox extends StatelessWidget {
  const CupertinoBox({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.titleSmall),
          child,
        ],
      ),
    );
  }
}
