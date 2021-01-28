
import 'package:flutter/material.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/model/StaffModel.dart';

class insertStafController{

  DatabaseHelper databaseHelper = DatabaseHelper();

  void addStaf(BuildContext ctx, String nik, String nama, String email, String password, String telepon) async{

    StaffModel staffModel=StaffModel(nik: nik, nama: nama, email: email, password: password, telepon: telepon);
    int hasil = await databaseHelper.insertStaf(staffModel);
    if (hasil != 0){
      snackBar(ctx, "Data berhasil disimpan");
    }
  }
  void insertStaf(BuildContext ctx, String nik, String nama, String email, String password, String telepon) async{

    StaffModel staffModel=StaffModel(nik: nik, nama: nama, email: email, password: password, telepon: telepon);
    int hasil = await databaseHelper.insertStaf(staffModel);
    debugPrint(hasil.toString());
  }
  void snackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
