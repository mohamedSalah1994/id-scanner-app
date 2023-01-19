import 'dart:convert';

import 'package:id_scanner/models/events_model.dart';

enum Event { event1, event2, event3, event4, event5 }

List<Event> events = [
  Event.event1,
  Event.event2,
  Event.event3,
  Event.event4,
  Event.event5
];

Event getEvent<T>(String name) {
  return Event.values.firstWhere((e) => e.name == name);
}
