
import 'package:flutter/material.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/model/StaffModel.dart';

class deleteStafController{

  DatabaseHelper databaseHelper = DatabaseHelper();

  void deleteStaf(BuildContext ctx, int id) async{
    int hasil = await databaseHelper.deleteStaf(id);
    if (hasil != 0){
      snackBar(ctx, "Data berhasil dihapus");
    }
  }

  void snackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
