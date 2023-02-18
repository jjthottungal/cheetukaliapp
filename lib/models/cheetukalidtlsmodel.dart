// To parse this JSON data, do
//
//     final cheetukaliDtlsModel = cheetukaliDtlsModelFromJson(jsonString);

import 'dart:convert';

List<CheetukaliDtlsModel> cheetukaliDtlsModelFromJson(String str) =>
    List<CheetukaliDtlsModel>.from(
        json.decode(str).map((x) => CheetukaliDtlsModel.fromJson(x)));

String cheetukaliDtlsModelToJson(List<CheetukaliDtlsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheetukaliDtlsModel {
  CheetukaliDtlsModel({
    required this.wgId,
    required this.playerName,
    required this.amount,
    required this.abr,
    required this.playerId,
  });

  int wgId;
  String playerName;
  double amount;
  String? abr;
  int playerId;

  factory CheetukaliDtlsModel.fromJson(Map<String, dynamic> json) =>
      CheetukaliDtlsModel(
        wgId: json["wg_id"],
        playerName: json["player_name"],
        amount: json["amount"].toDouble(),
        abr: json["abr"],
        playerId: json["player_id"],
      );

  Map<String, dynamic> toJson() => {
        "wg_id": wgId,
        "player_name": playerName,
        "amount": amount,
        "abr": abr,
        "player_id": playerId,
      };
}
