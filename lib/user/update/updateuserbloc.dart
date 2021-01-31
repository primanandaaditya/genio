import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'dart:async';
import 'package:manajemen/model/UserModel.dart';


class UpdateUserBloc extends Bloc<UserModel,int>{

  int id;
  int tecIdStaf;
  int tecHakAkses=0;
  int tecStatusAkun=0;


  UserModel createUserModel(){
    UserModel result = UserModel.withID(
      id: id,
     idStaf: int.parse(
         tecIdStaf.toString()),
      hakAkses: tecHakAkses.toString(),
      statusAkun: tecStatusAkun.toString()
    );
    return result;
  }

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(UserModel event) async* {

    try{
      int hasil = await updateUser(event);
      yield hasil;
    }catch(_){
      yield 0;
    }
  }

  static Future<int> updateUser(UserModel m) async {
    DatabaseHelper databaseHelper=DatabaseHelper();
    int hasil = await databaseHelper.updateUser(m);
    return hasil;
  }

  void snackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text("Data berhasil diedit"));
    Scaffold.of(context).showSnackBar(snackBar);
  }


  List<DropdownMenuItem> getHakAkses(){
    List<DropdownMenuItem> hasil=List();
    hasil.add(new DropdownMenuItem(value: 1, child: Text("Admin")));
    hasil.add(new DropdownMenuItem(value: 0, child: Text("Tamu")));
    return hasil;
  }

  List<DropdownMenuItem> getStatus(){
    List<DropdownMenuItem> hasil=List();
    hasil.add(new DropdownMenuItem(value: 1, child: Text("Aktif")));
    hasil.add(new DropdownMenuItem(value: 0, child: Text("Non Aktif")));
    return hasil;
  }

}
