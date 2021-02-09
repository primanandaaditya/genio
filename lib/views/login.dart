import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/views/LoginModel.dart';
import 'package:manajemen/views/dologinbloc.dart';
import 'package:manajemen/views/spbloc.dart';

final _formKey = GlobalKey<FormState>();
DoLoginBloc doLoginBloc;
SpBloc spBloc;


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: MultiBlocProvider(
          providers: [

            BlocProvider<DoLoginBloc>(
              builder: (BuildContext context) => DoLoginBloc(),
            ),
            BlocProvider<SpBloc>(
              builder: (BuildContext context) => SpBloc(),
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
    spBloc=BlocProvider.of<SpBloc>(context);

    return Container(

        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return KonstanString.kolomHarusDiisi;
                  }
                  return null;
                },
                controller: doLoginBloc.tecEmail,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return KonstanString.kolomHarusDiisi;
                  }
                  return null;
                },
                controller: doLoginBloc.tecPassword,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    LoginModel l = doLoginBloc.createLoginModel();
                    doLoginBloc.dispatch(l);
                  }
                },
                color: Colors.deepOrange,
                textColor: Colors.white,
                child: Text("Login"),
              ),

              BlocListener(
                  bloc: doLoginBloc,
                  listener: (BuildContext context, String state) {
                    debugPrint(state);
                    if (state == KonstanString.aksesAdmin || state == KonstanString.aksesTamu ) {
                      spBloc.simpanJenisAkses(state.toString());
                      Navigator.popAndPushNamed(context, '/home');
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
