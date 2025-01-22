import 'package:flutter/material.dart';

import 'features/on_this_day/view.dart';
import 'features/on_this_day/view_model.dart';
import 'features/ui/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ValueNotifier<bool> darkMode = ValueNotifier(false);

  _toggleDarkMode() {
    darkMode.value = !darkMode.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: darkMode,
      builder: (context, _) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.darkTheme,
          themeMode: darkMode.value ? ThemeMode.dark : ThemeMode.light,
          routes: {
            '/': (context) => HomeView(toggleDarkMode: _toggleDarkMode),
            '/timeline':
                (context) => OnThisDayView(viewModel: OnThisDayViewModel()),
          },
        );
      },
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.toggleDarkMode});

  final VoidCallback toggleDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.light_mode), onPressed: toggleDarkMode),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('WIKIPEDIA FLUTTER'),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/timeline'),
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
