import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/feed_view.dart';
import 'package:flutter_app/features/feed/feed_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.darkMode,
    required this.toggleDarkMode,
  });

  final bool darkMode;
  final Function(bool) toggleDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text('Dark mode'),
              Switch.adaptive(value: darkMode, onChanged: toggleDarkMode),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Welcome to\nDart Wikipedia!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/timeline'),
                child: Text('Timeline'),
              ),
              ElevatedButton(
                onPressed:
                    () => Navigator.of(context).pushNamed('/randomArticle'),
                child: Text('Random Article'),
              ),
              FeedView(viewModel: FeedViewModel()),
            ],
          ),
        ),
      ),
    );
  }
}
