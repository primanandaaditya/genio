import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'dart:async';
import 'package:manajemen/views/LoginModel.dart';


class DoLoginBloc extends Bloc<LoginModel,String>{

  TextEditingController tecEmail=TextEditingController();
  TextEditingController tecPassword=TextEditingController();


  LoginModel createLoginModel(){
    LoginModel result = LoginModel(
      email: tecEmail.text.toString(),
      password: tecPassword.text.toString()
    );
    return result;
  }

  @override
  String get initialState => "";

  @override
  Stream<String> mapEventToState(LoginModel event) async* {

    try{
      String hasil = await doLogin(event);
      yield hasil;
    }catch(_){
      yield "error";
    }
  }

  static Future<String> doLogin(LoginModel m) async {
    DatabaseHelper databaseHelper=DatabaseHelper();
    String hasil = await databaseHelper.doLogin(m.email, m.password);
    return hasil;
  }

  void snackBar(BuildContext context, String state) {
    final snackBar = SnackBar(content: Text(state));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void kosongkan(){
    tecEmail.text="";
    tecPassword.text="";
  }

}
