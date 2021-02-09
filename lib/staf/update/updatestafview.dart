import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/helper/konstanstring.dart';
import 'package:manajemen/helper/warna.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/staf/update/updatestafbloc.dart';
import 'package:manajemen/staf/update/updatestafcontroller.dart';

UpdateStafBloc updateStafBloc;
final _formKey = GlobalKey<FormState>();

class UpdateStafView extends StatelessWidget {

  StaffModel staffModel;
  UpdateStafView(this.staffModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Staf"),),
      body: BlocProvider(builder: (context) => UpdateStafBloc(),
        child: View(staffModel),
      )
    );
  }
}

class View extends StatelessWidget {

  StaffModel staffModel;
  View(this.staffModel);

  //init value


  @override
  Widget build(BuildContext context) {

    updateStafBloc = BlocProvider.of<UpdateStafBloc>(context);

    updateStafBloc.id = staffModel.id;
    updateStafBloc.tecNIK.text = staffModel.nik;
    updateStafBloc.tecNama.text = staffModel.nama;
    updateStafBloc.tecTelepon.text = staffModel.telepon;
    updateStafBloc.tecPassword.text = staffModel.password;
    updateStafBloc.tecEmail.text = staffModel.email;

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number, color: Warna.pink,),
                  hintText: "NIK"
              ),
              controller: updateStafBloc.tecNIK,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.people, color: Warna.pink,),
                  hintText: "Nama staf"
              ),
              controller: updateStafBloc.tecNama,
              validator: (value) {
                if (value.isEmpty) {
                  return KonstanString.kolomHarusDiisi;
                }
                return null;
              },
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Warna.pink,),
                  hintText: "Email"
              ),
              controller: updateStafBloc.tecEmail,
              validator: (value) {
                if (value.isEmpty) {
                  return KonstanString.kolomHarusDiisi;
                }
                return null;
              },
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.security, color: Warna.pink,),
                  hintText: "Password"
              ),
              controller: updateStafBloc.tecPassword,
              validator: (value) {
                if (value.isEmpty) {
                  return KonstanString.kolomHarusDiisi;
                }
                return null;
              },
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.phone, color: Warna.pink,),
                hintText: "Nomor telepon"
              ),
              controller: updateStafBloc.tecTelepon,
              style: TextStyle(
                  color: Colors.white
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            RaisedButton(

              onPressed: (){

                if (_formKey.currentState.validate()) {
                  StaffModel model = updateStafBloc.createStafModel();
                  updateStafBloc.dispatch(model);
                }
              },
              child: Text("Edit"),

            ),

            BlocListener(
                bloc: updateStafBloc,
                listener: (BuildContext context, int state) {
                  if (state >=0) {
                    updateStafBloc.snackBar(context);
                  }
                },

                child: BlocBuilder<UpdateStafBloc, int>(
                    builder: (context, hasil) {
                      if (hasil==0){
                        return Container();
                      }else if (hasil != 0){
                        return Container();
                      }else{
                        return Text("Gagal update!");
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
