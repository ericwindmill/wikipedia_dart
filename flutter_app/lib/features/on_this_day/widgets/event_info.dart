import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import '../../ui/theme.dart';

class EventInfo extends StatelessWidget {
  const EventInfo(this.event, {super.key});

  final OnThisDayEvent event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.type != EventType.holiday
              ? event.year!.absYear
              : event.type.humanReadable,
          style: AppTheme.timelineEntryTitle,
        ),
        SizedBox(height: 10),
        Text(event.text, style: TextTheme.of(context).bodyMedium),
        SizedBox(height: 10),
      ],
    );
  }
}
