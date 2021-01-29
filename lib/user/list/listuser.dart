import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/model/JoinModel.dart';
import 'package:manajemen/model/UserModel.dart';
import 'package:manajemen/user/list/listuserbloc.dart';


ListUserBloc listUserBloc;

class ListUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<ListUserBloc>(
          builder: (BuildContext context) => ListUserBloc(),
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


    listUserBloc = BlocProvider.of<ListUserBloc>(context);
    listUserBloc.dispatch(0);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () async{
         // await Navigator.push(context, MaterialPageRoute(builder: (context) => InsertStafView()),);
         // listStafBloc.dispatch(0);

        },
      ),
      appBar: AppBar(title: Text("Daftar User"),),
      body: Container(
        child:  BlocBuilder<ListUserBloc, List<JoinModel>>(
            builder: (context, hasil) {
              if (hasil==null){
                return Container();
              }else if (hasil is List<JoinModel>){
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.people),
                        subtitle:
                        Text(hasil.elementAt(index).hakAkses.toString(), textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr),
                        title:
                        Text(hasil.elementAt(index).namaStaf.toString(), textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              onPressed: () async {

                                // await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => UpdateStafView(hasil.elementAt(index))),
                                // );
                                // listStafBloc.dispatch(0);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (){
                                // dialogHapus(context, hasil.elementAt(index).id);
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
                    // deleteStafBloc.dispatch(id);
                    Navigator.pop(context);
                    // listStafBloc.dispatch(0);
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


