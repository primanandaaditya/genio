// To parse this JSON data, do
//
//     final staffModel = staffModelFromMap(jsonString);

import 'dart:convert';

StaffModel staffModelFromMap(String str) => StaffModel.fromMap(json.decode(str));

String staffModelToMap(StaffModel data) => json.encode(data.toMap());

class StaffModel {
  StaffModel({
    this.nik,
    this.nama,
    this.email,
    this.password,
    this.telepon,
  });

  StaffModel.withId({
    this.id,
    this.nik,
    this.nama,
    this.email,
    this.password,
    this.telepon,
  });

  int id;
  String nik;
  String nama;
  String email;
  String password;
  String telepon;

  factory StaffModel.fromMap(Map<String, dynamic> json) => StaffModel.withId(
    id: json["id"],
    nik: json["nik"],
    nama: json["nama"],
    email: json["email"],
    password: json["password"],
    telepon: json["telepon"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nik": nik,
    "nama": nama,
    "email": email,
    "password": password,
    "telepon": telepon,
  };
}

class StafInit extends StaffModel{}
