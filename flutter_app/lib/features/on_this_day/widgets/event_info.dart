import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class EventInfo extends StatelessWidget {
  const EventInfo(this.event, {super.key});

  final OnThisDayEvent event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (event.type != EventType.holiday)
          Text(event.year!.absYear, style: TextTheme.of(context).titleMedium),
        if (event.type == EventType.holiday)
          Text(
            event.type.humanReadable,
            style: TextTheme.of(context).titleMedium,
          ),
        SizedBox(height: 10),
        Text(event.text, style: TextTheme.of(context).bodyMedium),
        SizedBox(height: 10),
      ],
    );
  }
}
