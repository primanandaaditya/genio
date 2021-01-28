import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/staf/update/updatestafbloc.dart';
import 'package:manajemen/staf/update/updatestafcontroller.dart';

UpdateStafBloc updateStafBloc;

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
        child: ListView(
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number),
                  hintText: "NIK"
              ),
              controller: updateStafBloc.tecNIK,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.people),
                  hintText: "Nama staf"
              ),
              controller: updateStafBloc.tecNama,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: "Email"
              ),
              controller: updateStafBloc.tecEmail,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.security),
                  hintText: "Password"
              ),
              controller: updateStafBloc.tecPassword,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                hintText: "Nomor telepon"
              ),
              controller: updateStafBloc.tecTelepon,
            ),
            RaisedButton(
              color: Colors.deepOrange,
              onPressed: (){
                StaffModel model = updateStafBloc.createStafModel();
                updateStafBloc.dispatch(model);
              },
              child: Text("Edit"),
              textColor: Colors.white,
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
