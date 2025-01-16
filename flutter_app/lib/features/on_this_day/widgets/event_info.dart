import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class EventInfo extends StatelessWidget {
  const EventInfo(this.event, {super.key});

  final OnThisDayEvent event;

  String get heading {
    var str = StringBuffer();
    if (event.type != EventType.holiday) {
      str.write('${event.year!.absYear} - ');
    }
    str.write(event.type.humanReadable);
    return str.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: TextTheme.of(context).titleMedium),
        SizedBox(height: 10),
        Text(event.text, style: TextTheme.of(context).bodyMedium),
        SizedBox(height: 10),
      ],
    );
  }
}
