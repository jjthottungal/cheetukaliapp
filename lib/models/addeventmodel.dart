// To parse this JSON data, do
//
//     final addEventModel = addEventModelFromJson(jsonString);

import 'dart:convert';

AddEventModel addEventModelFromJson(String str) =>
    AddEventModel.fromJson(json.decode(str));

String addEventModelToJson(AddEventModel data) => json.encode(data.toJson());

class AddEventModel {
  AddEventModel({
    required this.wgId,
    required this.host,
    required this.wgDate,
    required this.note,
  });

  int wgId;
  int host;
  String wgDate;
  String note;

  factory AddEventModel.fromJson(Map<String, dynamic> json) => AddEventModel(
        wgId: json["wg_id"],
        host: json["host"],
        wgDate: json["wg_date"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "wg_id": wgId,
        "host": host,
        "wg_date": wgDate,
        "note": note,
      };
}
