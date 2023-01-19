// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    required this.status,
    required this.data,
  });

  String status;
  List<EventDatum> data;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        status: json["status"],
        data: List<EventDatum>.from(
            json["data"]!.map((x) => EventDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EventDatum {
  EventDatum({
    required this.eventId,
    required this.eventName,
    required this.eventColor,
  });

  String eventId;
  String eventName;
  String eventColor;

  factory EventDatum.fromJson(Map<String, dynamic> json) => EventDatum(
        eventId: json["event_id"],
        eventName: json["event_name"],
        eventColor: json["event_color"],
      );

  Map<String, dynamic> toJson() =>
      {"event_id": eventId, "event_name": eventName};
}
