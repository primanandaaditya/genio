import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/helper/warna.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/model/UserModel.dart';
import 'package:manajemen/staf/list/liststafbloc.dart';
import 'package:manajemen/user/insert/insertuserbloc.dart';


InsertUserBloc insertUserBloc;
ListStafBloc listStafBloc;
List<DropdownMenuItem> list=List();
final _formKey = GlobalKey<FormState>();


class InsertUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah User"),),
      body:  MultiBlocProvider(
        providers: [
          BlocProvider<ListStafBloc>(
            builder: (BuildContext context) => ListStafBloc(),
          ),
          BlocProvider<InsertUserBloc>(
            builder: (BuildContext context) => InsertUserBloc(),
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

    list.clear();
    insertUserBloc = BlocProvider.of<InsertUserBloc>(context);
    listStafBloc = BlocProvider.of<ListStafBloc>(context);
    listStafBloc.dispatch(0);

    return Container(
      padding: EdgeInsets.all(20),
      child: BlocBuilder<ListStafBloc, List<StaffModel>>(
          builder: (context, hasil) {
            if (hasil==null){
              return Container();
            }else if (hasil is List<StaffModel>){

              list.clear();
              hasil.forEach((x) {
                list.add( new DropdownMenuItem(value: x.id, child: Text(x.nama),));
              });

              return
                Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Pilih staf",
                          icon: Icon(Icons.people, color: Warna.pink,),
                          hintText: "Pilih staf"
                        ),
                        items: list,
                        onChanged: (x){
                          insertUserBloc.tecIdStaf=x;
                        },
                        value: insertUserBloc.tecIdStaf,
                        validator: (value) {
                          if (value.toString().isEmpty || value==null) {
                            return KonstanString.kolomHarusDiisi;
                          }
                          return null;
                        },

                      ),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Hak akses",
                            icon: Icon(Icons.accessible_forward, color: Warna.pink,),
                            hintText: "Hak akses"
                        ),
                        items: insertUserBloc.getHakAkses(),
                        onChanged: (x){
                          insertUserBloc.tecHakAkses=x;
                        },
                        value: insertUserBloc.tecHakAkses,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return KonstanString.kolomHarusDiisi;
                          }
                          return null;
                        },
                      ),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Status akun",
                            icon: Icon(Icons.account_box, color: Warna.pink,),
                            hintText: "Status akun",
                        ),
                        items: insertUserBloc.getStatus(),
                        onChanged: (x){
                          insertUserBloc.tecStatusAkun=x;
                        },
                        value: insertUserBloc.tecStatusAkun,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return KonstanString.kolomHarusDiisi;
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),

                      RaisedButton(

                        onPressed: (){
                          if (_formKey.currentState.validate()) {
                            UserModel model = insertUserBloc.createUserModel();
                            insertUserBloc.dispatch(model);
                          }
                        },
                        child: Text("Simpan"),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.orange)
                        ),
                        textColor: Colors.white,

                      ),

                      BlocListener(
                          bloc: insertUserBloc,
                          listener: (BuildContext context, int state) {
                            if (state >=0) {
                              insertUserBloc.snackBar(context);
                            }
                          },

                          child: BlocBuilder<InsertUserBloc, int>(
                              builder: (context, hasil) {
                                if (hasil==0){
                                  return Container();
                                }else if (hasil != 0){
                                  return Container();
                                }else{
                                  return Text("Gagal insert!");
                                }
                              }
                          )
                      ),
                    ],
                  ),
                );
            }else{
              return Text("Gagal fetch data!");
            }
          }
      )
    );
  }
}
