import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/theme/theme.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({super.key, this.title, this.actions});

  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    if (context.isCupertino) {
      return CupertinoNavigationBar(
        middle: Text(
          title ?? '',
          style: AppTheme.cupertinoTextTheme.titleLarge,
        ),
        trailing: Column(children: actions ?? []),
      );
    } else {
      return AppBar(
        title: Text(title ?? '', style: context.textTheme.titleLarge),
        actions: actions,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}
