import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/model/ListStafModel.dart';
import 'dart:async';
import 'package:manajemen/model/StaffModel.dart';


class ListStafBloc extends Bloc<int,List<StaffModel>>{


  @override
  List<StaffModel> get initialState => List<StaffModel>();

  @override
  Stream<List<StaffModel>> mapEventToState(int event) async* {

    try{
      List<StaffModel> hasil = await staffModels();
      yield hasil;
    }catch(_){

    }
  }

  Future<List<StaffModel>> staffModels() async {
    DatabaseHelper databaseHelper=DatabaseHelper();
    List<StaffModel> result = await databaseHelper.staffModels();
    return result;
  }

  void snackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text("Data berhasil ditambahkan"));
    Scaffold.of(context).showSnackBar(snackBar);
  }



}
