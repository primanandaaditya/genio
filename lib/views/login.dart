import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/staf/insert/insertStafController.dart';
import 'package:manajemen/views/LoginModel.dart';
import 'package:manajemen/views/dologinbloc.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController tcEmail = TextEditingController();
TextEditingController tcPassword = TextEditingController();
DoLoginBloc doLoginBloc;


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // DatabaseHelper databaseHelper=DatabaseHelper();
    // databaseHelper.doLogin("edit@gmail.comx", "editx").then((value) {
    //   debugPrint("hasil : " + value.toString());
    // });


    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: MultiBlocProvider(
        providers: [

          BlocProvider<DoLoginBloc>(
            builder: (BuildContext context) => DoLoginBloc(),
          ),

        ],
        child: View(),
      )
    );
  }
}

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    doLoginBloc = BlocProvider.of<DoLoginBloc>(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            TextFormField(
              controller: doLoginBloc.tecEmail,
            ),
            TextFormField(
              controller: doLoginBloc.tecPassword,
              obscureText: true,
            ),
            RaisedButton(
              onPressed: (){
                LoginModel l = doLoginBloc.createLoginModel();
                doLoginBloc.dispatch(l);

              },
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text("Login"),
            ),

            BlocListener(
                bloc: doLoginBloc,
                listener: (BuildContext context, String state) {
                  if (state == KonstanString.LOGIN_OK ) {
                    Navigator.pushNamed(context, '/listuser');
                  }else{
                    doLoginBloc.snackBar(context, state);
                  }
                },

                child: BlocBuilder<DoLoginBloc, String>(
                    builder: (context, hasil) {
                      if (hasil==  KonstanString.LOGIN_OK){
                        return Container();
                      }else{
                        return Container();
                      }
                    }
                )
            ),

          ],
        ),
      )
    );
  }
}
