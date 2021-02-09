import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'dart:async';
import 'package:manajemen/model/StaffModel.dart';


class InsertStafBloc extends Bloc<StaffModel,int>{

  TextEditingController tecNIK=TextEditingController();
  TextEditingController tecNama=TextEditingController();
  TextEditingController tecEmail=TextEditingController();
  TextEditingController tecPassword=TextEditingController();
  TextEditingController tecTelepon=TextEditingController();

  StaffModel createStafModel(){
    StaffModel result = StaffModel(
      nik: tecNIK.text.toString(),
      nama: tecNama.text.toString(),
      email: tecEmail.text.toString(),
      password: tecPassword.text.toString(),
      telepon: tecTelepon.text.toString()
    );
    return result;
  }

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(StaffModel event) async* {

    try{
      int hasil = await insertStaf(event);
      yield hasil;
    }catch(_){
      yield 0;
    }
  }

  static Future<int> insertStaf(StaffModel m) async {
    DatabaseHelper databaseHelper=DatabaseHelper();
    int hasil = await databaseHelper.insertStaf(m);
    return hasil;
  }

  void snackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text("Data berhasil ditambahkan"));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void kosongkan(){
    tecNIK.text="";
    tecNama.text="";
    tecEmail.text="";
    tecPassword.text="";
    tecTelepon.text="";
  }

}
