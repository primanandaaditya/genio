import 'dart:convert';

JoinModel joinModelFromMap(String str) => JoinModel.fromMap(json.decode(str));
String joinModelToMap(JoinModel data) => json.encode(data.toMap());

class JoinModel {
  JoinModel({
    this.id,
    this.idStaf,
    this.namaStaf,
    this.hakAkses,
    this.statusAkun,
  });

  int id;
  int idStaf;
  String namaStaf;
  String hakAkses;
  String statusAkun;

  factory JoinModel.fromMap(Map<String, dynamic> json) => JoinModel(
    id: json["id"],
    idStaf: json["idStaf"],
    namaStaf: json["namaStaf"],
    hakAkses: json["hakAkses"],
    statusAkun: json["statusAkun"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idStaf": idStaf,
    "namaStaf": namaStaf,
    "hakAkses": hakAkses,
    "statusAkun": statusAkun,
  };
}
