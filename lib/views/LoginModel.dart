// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'dart:convert';

LoginModel loginModelFromMap(String str) => LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  LoginModel({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "password": password,
  };
}

class LoginBegin extends LoginModel{}
