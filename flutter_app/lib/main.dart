import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Breakpoint breakpoint;
  bool darkMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    breakpoint = Breakpoint.currentDevice(context);
  }

  void _toggleDarkMode() {
    setState(() {
      darkMode = !darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BreakpointProvider(
      breakpoint: breakpoint,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        routes: routes,
        home: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                centerTitle: false,
                title: Text(
                  'Dart Wikipedia',
                  style: AppTheme.serifTitle.copyWith(fontSize: 30),
                ),
                actions: [
                  IconButton(
                    icon: Icon(darkMode ? Icons.light_mode : Icons.dark_mode),
                    onPressed: () => _toggleDarkMode(),
                  ),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: FeedView(viewModel: FeedViewModel()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
