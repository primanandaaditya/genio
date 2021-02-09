import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/home/itemlist.dart';
import 'package:manajemen/views/spbloc.dart';

SpBloc spBloc;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
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

    return Container(
      padding: EdgeInsets.all(20),
      child: BlocBuilder<SpBloc, String>(
          builder: (context, hasil) {
            if (hasil==  KonstanString.jenisAksesTidakDiketahui){
              return Container();
            }else{
              return ListView(
                children: <Widget>[

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
    );
  }
}

