import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/model/UserModel.dart';
import 'package:manajemen/staf/list/liststafbloc.dart';
import 'package:manajemen/user/update/updateuserbloc.dart';



UpdateUserBloc updateUserBloc;
ListStafBloc listStafBloc;
List<DropdownMenuItem> list=List();
final _formKey = GlobalKey<FormState>();


class UpdateUserView extends StatelessWidget {

  UserModel _model;
  UpdateUserView(this._model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update User"),),
      body:  MultiBlocProvider(
        providers: [
          BlocProvider<ListStafBloc>(
            builder: (BuildContext context) => ListStafBloc(),
          ),
          BlocProvider<UpdateUserBloc>(
            builder: (BuildContext context) => UpdateUserBloc(),
          ),
        ],
        child: View(this._model),
      )
    );
  }
}

class View extends StatelessWidget {

  UserModel _model;
  View(this._model);

  @override
  Widget build(BuildContext context) {

    list.clear();
    updateUserBloc = BlocProvider.of<UpdateUserBloc>(context);
    listStafBloc = BlocProvider.of<ListStafBloc>(context);
    listStafBloc.dispatch(0);

    updateUserBloc.id = this._model.id;
    updateUserBloc.tecIdStaf = this._model.idStaf;
    updateUserBloc.tecStatusAkun = int.parse( this._model.statusAkun.toString());
    updateUserBloc.tecHakAkses = int.parse(this._model.hakAkses);

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
                          icon: Icon(Icons.people),
                          hintText: "Pilih staf"
                        ),
                        items: list,
                        onChanged: (x){
                          updateUserBloc.tecIdStaf=x;
                        },
                        value: updateUserBloc.tecIdStaf,
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
                            icon: Icon(Icons.accessible_forward),
                            hintText: "Hak akses"
                        ),
                        items: updateUserBloc.getHakAkses(),
                        onChanged: (x){
                          updateUserBloc.tecHakAkses=x;
                        },
                        value: updateUserBloc.tecHakAkses,
                        validator: (value) {
                          if (value.toString().isEmpty || value==null) {
                            return KonstanString.kolomHarusDiisi;
                          }
                          return null;
                        },
                      ),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Status akun",
                            icon: Icon(Icons.account_box),
                            hintText: "Status akun",
                        ),
                        items: updateUserBloc.getStatus(),
                        onChanged: (x){
                          updateUserBloc.tecStatusAkun=x;
                        },
                        value: updateUserBloc.tecStatusAkun,
                        validator: (value) {
                          if (value.toString().isEmpty || value==null) {
                            return KonstanString.kolomHarusDiisi;
                          }
                          return null;
                        },
                      ),


                      RaisedButton(
                        color: Colors.deepOrange,
                        onPressed: (){
                          if (_formKey.currentState.validate()) {
                            UserModel model = updateUserBloc.createUserModel();
                            updateUserBloc.dispatch(model);
                          }
                        },
                        child: Text("Edit"),
                        textColor: Colors.white,
                      ),

                      BlocListener(
                          bloc: updateUserBloc,
                          listener: (BuildContext context, int state) {
                            if (state >=0) {
                              updateUserBloc.snackBar(context);
                            }
                          },

                          child: BlocBuilder<UpdateUserBloc, int>(
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
