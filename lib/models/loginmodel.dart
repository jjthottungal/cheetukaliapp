// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.userId,
    required this.password,
  });

  String userId;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userId: json["UserID"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "Password": password,
      };
}
