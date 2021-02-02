import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'dart:async';
import 'package:manajemen/views/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SpBloc extends Bloc<int,String>{


  @override
  String get initialState => KonstanString.jenisAksesTidakDiketahui;

  @override
  Stream<String> mapEventToState(int event) async* {

    try{
      String hasil = await getJenisAkses();
      yield hasil;
    }catch(_){
      yield KonstanString.jenisAksesTidakDiketahui;
    }
  }

  Future<String> getJenisAkses() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(KonstanString.jenisAkses)??KonstanString.aksesTamu;
  }

  void simpanJenisAkses(String string) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(KonstanString.jenisAkses, string);
  }

}
