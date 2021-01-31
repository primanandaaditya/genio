import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'dart:async';



class DeleteUserBloc extends Bloc<int,int>{

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int event) async* {
    try{
      int hasil = await deleteUser(event);
      yield hasil;
    }catch(_){
      yield 0;
    }
  }

  static Future<int> deleteUser(int m) async {
    DatabaseHelper databaseHelper=DatabaseHelper();
    int hasil = await databaseHelper.deleteUser(m);
    return hasil;
  }

  void snackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text("Data berhasil dihapus"));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
