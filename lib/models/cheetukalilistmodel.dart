// To parse this JSON data, do
//
//     final cheetukaliListModel = cheetukaliListModelFromJson(jsonString);

import 'dart:convert';

CheetukaliListModel cheetukaliListModelFromJson(String str) =>
    CheetukaliListModel.fromJson(json.decode(str));

String cheetukaliListModelToJson(CheetukaliListModel data) =>
    json.encode(data.toJson());

class CheetukaliListModel {
  CheetukaliListModel({
    required this.date,
    required this.dateInText,
    required this.host,
    required this.result,
    required this.wgId,
  });

  DateTime date;
  String dateInText;
  String host;
  String result;
  int wgId;

  factory CheetukaliListModel.fromJson(Map<String, dynamic> json) =>
      CheetukaliListModel(
        date: DateTime.parse(json["Date"]),
        dateInText: json["DateInText"],
        host: json["Host"],
        result: json["Result"],
        wgId: json["wg_id"],
      );

  Map<String, dynamic> toJson() => {
        "Date": date.toIso8601String(),
        "DateInText": dateInText,
        "Host": host,
        "Result": result,
        "wg_id": wgId,
      };
}
