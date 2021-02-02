import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/model/JoinModel.dart';
import 'package:manajemen/model/UserModel.dart';
import 'package:manajemen/user/delete/deleteuserbloc.dart';
import 'package:manajemen/user/insert/insertuserview.dart';
import 'package:manajemen/user/list/listuserbloc.dart';
import 'package:manajemen/user/update/updateuserview.dart';
import 'package:manajemen/views/spbloc.dart';


ListUserBloc listUserBloc;
DeleteUserBloc deleteUserBloc;
SpBloc spBloc;

class ListUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<ListUserBloc>(
          builder: (BuildContext context) => ListUserBloc(),
        ),
        BlocProvider<DeleteUserBloc>(
          builder: (BuildContext context) => DeleteUserBloc(),
        ),
        BlocProvider<SpBloc>(
          builder: (BuildContext context) => SpBloc(),
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

    deleteUserBloc=BlocProvider.of<DeleteUserBloc>(context);
    listUserBloc = BlocProvider.of<ListUserBloc>(context);
    spBloc=BlocProvider.of<SpBloc>(context);

    spBloc.dispatch(0);
    listUserBloc.dispatch(0);


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () async{
         await Navigator.push(context, MaterialPageRoute(builder: (context) => InsertUserView()),);
         listUserBloc.dispatch(0);

        },
      ),
      appBar: AppBar(title: Text("Daftar User"),),
      body: Container(
        child:  BlocBuilder<SpBloc, String>(
            builder: (context, jenisAkses) {
              debugPrint("jenisAkses : " + jenisAkses);
              if (jenisAkses==KonstanString.jenisAksesTidakDiketahui){
                return Container();
              }else{
                return BlocBuilder<ListUserBloc, List<JoinModel>>(
                    builder: (context, hasil) {
                      if (hasil==null){
                        return Container();
                      }else if (hasil is List<JoinModel>){
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(Icons.people),
                                subtitle:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    hasil.elementAt(index).hakAkses.toString()=="1"?Text("Admin"):Text("Tamu"),
                                    hasil.elementAt(index).statusAkun.toString()=="1"?Text("Aktif"):Text("Non aktif"),
                                  ],
                                ),

                                title:
                                Text(hasil.elementAt(index).namaStaf.toString(), textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () async {

                                        UserModel m = UserModel.withID(id: hasil.elementAt(index).id, idStaf: hasil.elementAt(index).idStaf, hakAkses: hasil.elementAt(index).hakAkses, statusAkun: hasil.elementAt(index).statusAkun  );
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => UpdateUserView(m)),
                                        );
                                        listUserBloc.dispatch(0);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    jenisAkses == KonstanString.aksesAdmin ?
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: (){
                                        dialogHapus(context, hasil.elementAt(index).id);
                                      },
                                    ): Container()
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
                );
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
                    deleteUserBloc.dispatch(id);
                    Navigator.pop(context);
                    listUserBloc.dispatch(0);
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


