import 'package:flutter/material.dart';
import 'package:flutter_app/features/random_article/random_article_view.dart';
import 'package:flutter_app/features/random_article/random_article_view_model.dart';
import 'features/on_this_day/timeline_view.dart';
import 'features/on_this_day/timeline_view_model.dart';
import 'features/ui/theme.dart';
import 'home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool darkMode = false;

  _toggleDarkMode(bool value) {
    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        '/timeline': (context) => TimelineView(viewModel: TimelineViewModel()),
        '/randomArticle':
            (context) => RandomArticleView(viewModel: RandomArticleViewModel()),
      },
      home: HomeView(darkMode: darkMode, toggleDarkMode: _toggleDarkMode),
    );
  }
}
