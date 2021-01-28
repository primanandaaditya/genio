import 'package:flutter/material.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/staf/delete/deleteStafController.dart';
import 'package:manajemen/staf/update/updatestafview.dart';
import 'package:sqflite/sqflite.dart';

DatabaseHelper databaseHelper=DatabaseHelper();
deleteStafController hapusStaf;
int jumlahBaris =0 ;
List<StaffModel> listStaf;

class ListStaf extends StatefulWidget {
  @override
  _ListStafState createState() => _ListStafState();
}

class _ListStafState extends State<ListStaf> {
  @override
  Widget build(BuildContext context) {

    refreshList();
    hapusStaf=deleteStafController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.pushNamed(context, "/addstaf");
        },
      ),
      appBar: AppBar(title: Text("Daftar Staf"),),
      body: Container(
        child:  ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                  leading: Icon(Icons.people),
                  subtitle:
                  Text(listStaf.elementAt(index).email, textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr),
                  title:
                  Text(listStaf.elementAt(index).nama, textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateStafView(listStaf.elementAt(index))),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        dialogHapus(context, listStaf.elementAt(index).id);
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

            itemCount: jumlahBaris)
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
                    hapusStaf.deleteStaf(context, id);
                    Navigator.pop(context);
                    refreshList();
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

  void refreshList(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((resulta) {
      Future<List<StaffModel>> fromDB = databaseHelper.staffModels();
      fromDB.then((result) {
        setState(() {
          listStaf = result;
          jumlahBaris = result.length;
        });
      });
    });
  }
}


