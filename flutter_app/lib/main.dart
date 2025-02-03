import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_repository.dart';
import 'package:flutter_app/features/on_this_day/timeline_repository.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_repository.dart';
import 'package:flutter_app/providers/breakpoint_provider.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/ui/breakpoint.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/theme/theme.dart';

void main() async {
  runApp(
    RepositoryProvider(
      feedRepository: FeedRepository(),
      timelineRepository: TimelineRepository(),
      savedArticlesRepository: SavedArticlesRepository(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Breakpoint breakpoint;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    breakpoint = Breakpoint.currentDevice(context);
  }

  @override
  Widget build(BuildContext context) {
    return BreakpointProvider(
      breakpoint: breakpoint,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme:
                context.isCupertino
                    ? AppTheme.cupertinoLightTheme
                    : AppTheme.materialLightTheme,
            debugShowCheckedModeBanner: false,
            routes: routes,
          );
        },
      ),
    );
  }
}
