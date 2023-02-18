// To parse this JSON data, do
//
//     final cheetukaliFamSummModel = cheetukaliFamSummModelFromJson(jsonString);

import 'dart:convert';

CheetukaliFamSummModel cheetukaliFamSummModelFromJson(String str) =>
    CheetukaliFamSummModel.fromJson(json.decode(str));

String cheetukaliFamSummModelToJson(CheetukaliFamSummModel data) =>
    json.encode(data.toJson());

class CheetukaliFamSummModel {
  CheetukaliFamSummModel({
    required this.amount,
    required this.familyName,
  });

  double amount;
  String familyName;

  factory CheetukaliFamSummModel.fromJson(Map<String, dynamic> json) =>
      CheetukaliFamSummModel(
        amount: json["amount"].toDouble(),
        familyName: json["family_name"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "family_name": familyName,
      };
}
