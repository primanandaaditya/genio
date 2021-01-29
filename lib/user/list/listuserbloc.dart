import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/model/JoinModel.dart';
import 'dart:async';


List<DropdownMenuItem> list=List();

class ListUserBloc extends Bloc<int,List<JoinModel>>{

  @override
  List<JoinModel> get initialState => List<JoinModel>();

  @override
  Stream<List<JoinModel>> mapEventToState(int event) async* {

    try{
      List<JoinModel> hasil = await allUser();
      yield hasil;
    }catch(_){

    }
  }

  Future<List<JoinModel>> allUser() async {
    DatabaseHelper databaseHelper=DatabaseHelper();
    List<JoinModel> result = await databaseHelper.joinModel();
    return result;
  }

  void snackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text("Data berhasil ditambahkan"));
    Scaffold.of(context).showSnackBar(snackBar);
  }



}
