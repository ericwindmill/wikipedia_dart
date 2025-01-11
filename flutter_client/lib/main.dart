import 'package:flutter/material.dart';
import 'package:flutter_client/features/on_this_day/view.dart';

import 'features/on_this_day/view_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OnThisDayView(viewModel: OnThisDayViewModel()));
  }
}
