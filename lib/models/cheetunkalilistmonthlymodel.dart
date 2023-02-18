// To parse this JSON data, do
//
//     final cheetukaliListMonthlyModel = cheetukaliListMonthlyModelFromJson(jsonString);

import 'dart:convert';

List<CheetukaliListMonthlyModel> cheetukaliListMonthlyModelFromJson(
        String str) =>
    List<CheetukaliListMonthlyModel>.from(
        json.decode(str).map((x) => CheetukaliListMonthlyModel.fromJson(x)));

String cheetukaliListMonthlyModelToJson(
        List<CheetukaliListMonthlyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheetukaliListMonthlyModel {
  CheetukaliListMonthlyModel({
    required this.monthly,
    required this.events,
  });

  String monthly;
  List<Event> events;

  factory CheetukaliListMonthlyModel.fromJson(Map<String, dynamic> json) =>
      CheetukaliListMonthlyModel(
        monthly: json["Monthly"],
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Monthly": monthly,
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    required this.wgId,
    required this.host,
    required this.dateInText,
    required this.result,
    required this.date,
  });

  int wgId;
  String host;
  String dateInText;
  String result;
  DateTime date;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        wgId: json["wg_id"],
        host: json["Host"],
        dateInText: json["DateInText"],
        result: json["Result"],
        date: DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "wg_id": wgId,
        "Host": host,
        "DateInText": dateInText,
        "Result": result,
        "Date": date.toIso8601String(),
      };
}
