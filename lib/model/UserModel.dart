
import 'dart:convert';
UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));
String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    this.id,
    this.idStaf,
    this.hakAkses,
    this.statusAkun,
  });

  int id;
  int idStaf;
  String hakAkses;
  String statusAkun;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    idStaf: json["idStaf"],
    hakAkses: json["hakAkses"],
    statusAkun: json["statusAkun"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idStaf": idStaf,
    "hakAkses": hakAkses,
    "statusAkun": statusAkun,
  };
}
