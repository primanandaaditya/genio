import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/staf/delete/deleteStafController.dart';
import 'package:manajemen/staf/insert/insertstafview.dart';
import 'package:manajemen/staf/list/deletestafbloc.dart';
import 'package:manajemen/staf/list/liststafbloc.dart';
import 'package:manajemen/staf/update/updatestafview.dart';
import 'package:sqflite/sqflite.dart';


DeleteStafBloc deleteStafBloc;
ListStafBloc listStafBloc;

class ListStafView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeleteStafBloc>(
          builder: (BuildContext context) => DeleteStafBloc(),
        ),
        BlocProvider<ListStafBloc>(
          builder: (BuildContext context) => ListStafBloc(),
        ),
      ],
      child: ListStaf(),
    );
  }
}


class ListStaf extends StatefulWidget {
  @override
  _ListStafState createState() => _ListStafState();
}

class _ListStafState extends State<ListStaf> {



  @override
  Widget build(BuildContext context) {

    deleteStafBloc = BlocProvider.of<DeleteStafBloc>(context);
    listStafBloc = BlocProvider.of<ListStafBloc>(context);

    listStafBloc.dispatch(0);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () async{
          // Navigator.pushNamed(context, "/addstaf");
         await Navigator.push(context, MaterialPageRoute(builder: (context) => InsertStafView()),);
         listStafBloc.dispatch(0);

        },
      ),
      appBar: AppBar(title: Text("Daftar Staf"),),
      body: Container(
        child:  BlocBuilder<ListStafBloc, List<StaffModel>>(
            builder: (context, hasil) {
              if (hasil==null){
                return Container();
              }else if (hasil is List<StaffModel>){
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.people),
                        subtitle:
                        Text(hasil.elementAt(index).email, textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr),
                        title:
                        Text(hasil.elementAt(index).nama, textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UpdateStafView(hasil.elementAt(index))),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (){
                                dialogHapus(context, hasil.elementAt(index).id);
                              },
                            )
                          ],
                        ),
                      );
                    },

                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey,
                      );
                    },

                    itemCount: hasil.length);
              }else{
                return Text("Gagal fetch data!");
              }
            }
        )
      ),
    );
  }

  void dialogHapus(BuildContext context, int id){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Awas"),
            content: Text("Yakin mau hapus?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    deleteStafBloc.dispatch(id);
                    Navigator.pop(context);
                    listStafBloc.dispatch(0);
                  },
                  child: Text("Ya")
              ),

              FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Tidak")
              ),
            ],
          );
        }
    );
  }


}


