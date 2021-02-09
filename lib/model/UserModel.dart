
import 'dart:convert';
UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));
String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {

  UserModel.withID({
    this.id,
    this.idStaf,
    this.hakAkses,
    this.statusAkun,
  });

  UserModel({
    this.idStaf,
    this.hakAkses,
    this.statusAkun,
  });

  int id;
  int idStaf;
  String hakAkses;
  String statusAkun;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel.withID(
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

class UserInit extends UserModel{}
