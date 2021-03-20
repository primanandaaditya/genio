import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/helper/warna.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/staf/insert/insertstafbloc.dart';

InsertStafBloc insertStafBloc;
final _formKey = GlobalKey<FormState>();

class InsertStafView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Staf"),),
      body:  BlocProvider(builder: (context) => InsertStafBloc(),
        child: View(),
      )
    );
  }
}

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    insertStafBloc = BlocProvider.of<InsertStafBloc>(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number, color: Warna.putih,),
                  hintText: "NIK",

              ),
              controller: insertStafBloc.tecNIK,
            ),

            TextFormField(

              decoration: InputDecoration(
                  icon: Icon(Icons.people, color: Warna.putih,),
                  hintText: "Nama staf"
              ),
              controller: insertStafBloc.tecNama,
              validator: (value) {
                if (value.isEmpty) {
                  return KonstanString.kolomHarusDiisi;
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Warna.putih,),
                  hintText: "Email"
              ),
              controller: insertStafBloc.tecEmail,
              validator: (value) {
                if (value.isEmpty) {
                  return KonstanString.kolomHarusDiisi;
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.security, color: Warna.putih,),
                  hintText: "Password"
              ),
              controller: insertStafBloc.tecPassword,
              validator: (value) {
                if (value.isEmpty) {
                  return KonstanString.kolomHarusDiisi;
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.phone, color: Warna.putih,),
                hintText: "Nomor telepon"
              ),
              controller: insertStafBloc.tecTelepon,
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            RaisedButton(

              onPressed: (){
                if (_formKey.currentState.validate()) {
                  StaffModel model = insertStafBloc.createStafModel();
                  insertStafBloc.dispatch(model);
                  insertStafBloc.kosongkan();
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
                bloc: insertStafBloc,
                listener: (BuildContext context, int state) {
                  if (state >=0) {
                    insertStafBloc.snackBar(context);
                  }
                },

                child: BlocBuilder<InsertStafBloc, int>(
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
      ),
    );
  }
}
