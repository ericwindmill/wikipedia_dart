import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/theme/breakpoint.dart';
import 'package:flutter_app/ui/theme/theme.dart';

void main() async {
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

  // This viewModel doesn't need to reload when setstate is called
  final FeedViewModel viewModel = FeedViewModel();

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
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                centerTitle: false,
                title: Text(
                  AppStrings.wikipediaDart,
                  style: TextTheme.of(context).headlineMedium!.copyWith(
                    fontFamily: AppTheme.serif.fontFamily,
                    fontFamilyFallback: AppTheme.serif.fontFamilyFallback,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(darkMode ? Icons.light_mode : Icons.dark_mode),
                    onPressed: _toggleDarkMode,
                  ),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: FeedView(viewModel: viewModel),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
