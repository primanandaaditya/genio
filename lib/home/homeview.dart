import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/clipper/WaveClipper.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/home/itemlist.dart';
import 'package:manajemen/views/spbloc.dart';

SpBloc spBloc;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
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

    spBloc=BlocProvider.of<SpBloc>(context);
    spBloc.dispatch(0);

    return Stack(
      children: <Widget>[


        Opacity( //semi red cl// ippath with more height and with 0.5 opacity
          opacity: 0.8,
          child: ClipPath(
            clipper:WaveClipper(), //set our custom wave clipper
            child:Container(
              color:Colors.deepOrange,
              height:200,
            ),
          ),
        ),

        ClipPath(  //upper clippath with less height
          clipper:WaveClipper(), //set our custom wave clipper.
          child:Container(
            padding: EdgeInsets.only(bottom: 50),
            color:Colors.deepOrange,
            height:180,
            alignment: Alignment.center,

          ),
        ),

        Container(
          padding: EdgeInsets.all(20),
          child: BlocBuilder<SpBloc, String>(
              builder: (context, hasil) {
                if (hasil==  KonstanString.jenisAksesTidakDiketahui){
                  return Container();
                }else{
                  return ListView(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(top: 160),
                      ),

                      InkWell(
                        child: ItemList("images/user.png","Daftar Staf","Manajemen para staf (Create,Read,Update,Delete)"),
                        onTap: (){
                          Navigator.pushNamed(context, "/liststaf");
                        },
                      ),

                      InkWell(
                        child: ItemList("images/programmer.png","Daftar User","Manajemen para user (Create,Read,Update,Delete)"),
                        onTap: (){
                          Navigator.pushNamed(context, "/listuser");
                        },
                      ),

                      InkWell(
                        child: ItemList("images/arrow.png","Logout","Login dengan email lain"),
                        onTap: (){
                          spBloc.logout();
                          Navigator.popAndPushNamed(context, "/login");
                        },
                      )

                    ],
                  );
                }
              }
          ),
        )

      ],
    );
  }
}

