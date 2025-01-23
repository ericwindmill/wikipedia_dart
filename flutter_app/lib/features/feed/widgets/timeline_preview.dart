import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelinePreview extends StatelessWidget {
  const TimelinePreview({super.key, required this.events});

  final List<OnThisDayEvent> events;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
