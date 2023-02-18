// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

List<UserListModel> userListModelFromJson(String str) =>
    List<UserListModel>.from(
        json.decode(str).map((x) => UserListModel.fromJson(x)));

String userListModelToJson(List<UserListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListModel {
  UserListModel({
    required this.playerId,
    required this.playerName,
    required this.type,
  });

  int playerId;
  String playerName;
  String type;

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        playerId: json["player_id"],
        playerName: json["player_name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "player_id": playerId,
        "player_name": playerName,
        "type": type,
      };
}
