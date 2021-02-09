import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/helper/warna.dart';
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
      padding: EdgeInsets.all(40),
      color: Warna.hitam1,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

              Text("LOGIN",
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 30,
                  color: Warna.pink
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
              ),

              TextFormField(

                decoration: InputDecoration(
                  icon: Icon(Icons.people, color: Colors.white,),
                  labelText: "Username",

                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return KonstanString.kolomHarusDiisi;
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                controller: doLoginBloc.tecEmail,
              ),

              TextFormField(

                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key, color: Colors.white,),
                    labelText: "Password",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return KonstanString.kolomHarusDiisi;
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.white
                ),
                controller: doLoginBloc.tecPassword,
                obscureText: true,
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
              ),

              SizedBox(
                // height: 60,
                width: 30,
                child: RaisedButton(

                  // padding: EdgeInsets.all(10),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: new BorderRadius.circular(18.0),
                  //     side: BorderSide(color: Warna.kuning)
                  // ),
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      LoginModel l = doLoginBloc.createLoginModel();
                      doLoginBloc.dispatch(l);
                    }
                  },

                  child: Text("LOGIN"),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
              ),

              Text("Default: admin admin", textAlign: TextAlign.center, style: TextStyle(color: Warna.putih),),


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
