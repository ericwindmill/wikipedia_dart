import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class HolidayInfo extends StatelessWidget {
  const HolidayInfo(this.holiday, {super.key});

  final Holiday holiday;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BirthdayInfo extends StatelessWidget {
  const BirthdayInfo(this.event, {super.key});

  final Birthday event;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NotableDeathInfo extends StatelessWidget {
  const NotableDeathInfo(this.event, {super.key});

  final NotableDeath event;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class EventInfo extends StatelessWidget {
  const EventInfo(this.event, {super.key});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class FeaturedEventInfo extends StatelessWidget {
  const FeaturedEventInfo(this.event, {super.key});

  final FeaturedEvent event;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
