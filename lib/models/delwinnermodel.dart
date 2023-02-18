// To parse this JSON data, do
//
//     final delWinnerModel = delWinnerModelFromJson(jsonString);

import 'dart:convert';

DelWinnerModel delWinnerModelFromJson(String str) =>
    DelWinnerModel.fromJson(json.decode(str));

String delWinnerModelToJson(DelWinnerModel data) => json.encode(data.toJson());

class DelWinnerModel {
  DelWinnerModel({
    required this.wgId,
    required this.playerId,
  });

  int wgId;
  int playerId;

  factory DelWinnerModel.fromJson(Map<String, dynamic> json) => DelWinnerModel(
        wgId: json["wg_id"],
        playerId: json["player_id"],
      );

  Map<String, dynamic> toJson() => {
        "wg_id": wgId,
        "player_id": playerId,
      };
}
