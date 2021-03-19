import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/clipper/TopClipper.dart';
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

        ClipPath(  //upper clippath with less height
          clipper:TopClipper(), //set our custom wave clipper.
          child:Container(
            padding: EdgeInsets.only(bottom: 50),
            color:Colors.blue,
            height:250,
            alignment: Alignment.center,

          ),
        ),


        Container(
          padding: EdgeInsets.only(top: 50),
          child:  Align(
            alignment: Alignment.topCenter,
            child: Text("MAIN MENU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.center,),
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
                        padding: EdgeInsets.only(top: 70),
                      ),

                      Row(

                        children: <Widget>[

                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Container(
                                    height: 200,
                                    child: Column(
                                      children: <Widget>[

                                        Image.asset('images/programmer.png', height: 90, width: 90,),
                                        Padding(padding: EdgeInsets.only(top: 30),),
                                        Text("Staf", style: TextStyle(color: Colors.black, fontSize: 20),)
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    )

                                ),
                                elevation: 20,
                              ),
                              onTap: (){
                                Navigator.pushNamed(context, "/liststaf");
                              },
                            ),
                          ),

                          Expanded(
                            child: InkWell(
                              child: Card(
                                child: Container(
                                    height: 200,
                                    child: Column(
                                      children: <Widget>[

                                        Image.asset('images/superhero.png', height: 90, width: 90,),
                                        Padding(padding: EdgeInsets.only(top: 30),),
                                        Text("Role", style: TextStyle(color: Colors.black, fontSize: 20),)
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    )

                                ),
                                elevation: 20,
                              ),
                              onTap: (){
                                Navigator.pushNamed(context, "/listuser");
                              },
                            ),
                          ),

                        ],

                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),

                      InkWell(
                        onTap: (){
                          spBloc.logout();
                          Navigator.popAndPushNamed(context, "/login");
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle
                          ),
                          child: Center(
                            child: Column(

                              children: <Widget>[
                                Text("LOGOUT", style: TextStyle(color: Colors.white),),
                                Icon(Icons.arrow_forward, color: Colors.white,),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            )
                          ),
                        ),
                      ),

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

