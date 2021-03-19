import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/clipper/BottomWaveClipper.dart';
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
    doLoginBloc.tecEmail.text="admin";
    doLoginBloc.tecPassword.text="admin";

    return Stack(

      children: <Widget>[

        Opacity( //semi red cl// ippath with more height and with 0.5 opacity
          opacity: 0.8,
          child: ClipPath(
            clipper:BottomWaveClipper(), //set our custom wave clipper
            child:Container(
              color:Colors.blue,
              height:200,
            ),
          ),
        ),

        ClipPath(  //upper clippath with less height
          clipper:BottomWaveClipper(), //set our custom wave clipper.
          child:Container(
              padding: EdgeInsets.only(bottom: 50),
              color:Colors.blue,
              height:180,
              alignment: Alignment.center,

          ),
        ),

        Container(
            padding: EdgeInsets.all(40),

            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[

                  Text("LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 80),
                  ),

                  TextFormField(

                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return KonstanString.kolomHarusDiisi;
                      }
                      return null;
                    },
                    controller: doLoginBloc.tecEmail,
                  ),

                  TextFormField(

                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return KonstanString.kolomHarusDiisi;
                      }
                      return null;
                    },
                    controller: doLoginBloc.tecPassword,
                    obscureText: true,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),


                  InkWell(
                    onTap: (){
                      if (_formKey.currentState.validate()) {
                        LoginModel l = doLoginBloc.createLoginModel();
                        doLoginBloc.dispatch(l);
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_forward, color: Colors.white,),
                      ),
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
        )

      ],

    );
  }
}


