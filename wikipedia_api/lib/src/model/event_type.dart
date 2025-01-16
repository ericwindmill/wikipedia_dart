enum EventType {
  holiday('Holiday'),
  birthday('Birthday'),
  death('Notable death'),
  event('Event'),
  selected('Wikipedia featured event');

  final String humanReadable;

  const EventType(this.humanReadable);
}
