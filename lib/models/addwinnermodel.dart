// To parse this JSON data, do
//
//     final addWinnerModel = addWinnerModelFromJson(jsonString);

import 'dart:convert';

AddWinnerModel addWinnerModelFromJson(String str) =>
    AddWinnerModel.fromJson(json.decode(str));

String addWinnerModelToJson(AddWinnerModel data) => json.encode(data.toJson());

class AddWinnerModel {
  AddWinnerModel({
    required this.wgId,
    required this.playerId,
    required this.amount,
  });

  int wgId;
  int playerId;
  int amount;

  factory AddWinnerModel.fromJson(Map<String, dynamic> json) => AddWinnerModel(
        wgId: json["wg_id"],
        playerId: json["player_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "wg_id": wgId,
        "player_id": playerId,
        "amount": amount,
      };
}
