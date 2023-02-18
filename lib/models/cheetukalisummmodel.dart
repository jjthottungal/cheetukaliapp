// To parse this JSON data, do
//
//     final cheetukaliSummModel = cheetukaliSummModelFromJson(jsonString);

import 'dart:convert';

CheetukaliSummModel cheetukaliSummModelFromJson(String str) =>
    CheetukaliSummModel.fromJson(json.decode(str));

String cheetukaliSummModelToJson(CheetukaliSummModel data) =>
    json.encode(data.toJson());

class CheetukaliSummModel {
  CheetukaliSummModel({
    required this.amount,
    required this.playerId,
    required this.playerName,
  });

  double amount;
  int playerId;
  String playerName;

  factory CheetukaliSummModel.fromJson(Map<String, dynamic> json) =>
      CheetukaliSummModel(
        amount: json["amount"].toDouble(),
        playerId: json["player_id"],
        playerName: json["player_name"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "player_id": playerId,
        "player_name": playerName,
      };
}
