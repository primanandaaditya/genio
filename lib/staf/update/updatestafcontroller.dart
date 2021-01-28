
import 'package:flutter/material.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/model/StaffModel.dart';

class updatestafcontroller{

  DatabaseHelper databaseHelper = DatabaseHelper();

  void updateStaf(BuildContext ctx, int id, String nik, String nama, String email, String password, String telepon) async{

    StaffModel staffModel=StaffModel.withId(id: id,nik: nik, nama: nama, email: email, password: password, telepon: telepon);
    int hasil = await databaseHelper.updateStaf(staffModel);
    if (hasil != 0){
      snackBar(ctx, "Data berhasil diedit");
    }
  }

  void snackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
