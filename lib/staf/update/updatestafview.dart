import 'package:flutter/material.dart';
import 'package:manajemen/model/StaffModel.dart';
import 'package:manajemen/staf/update/updatestafcontroller.dart';

updatestafcontroller isc=updatestafcontroller();
TextEditingController tecNIK=TextEditingController();
TextEditingController tecNama=TextEditingController();
TextEditingController tecEmail=TextEditingController();
TextEditingController tecPassword=TextEditingController();
TextEditingController tecTelepon=TextEditingController();

class UpdateStafView extends StatelessWidget {

  StaffModel staffModel;
  UpdateStafView(this.staffModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Staf"),),
      body: View(staffModel),
    );
  }
}

class View extends StatelessWidget {

  StaffModel staffModel;
  View(this.staffModel);

  //init value


  @override
  Widget build(BuildContext context) {

    tecNIK.text = staffModel.nik;
    tecNama.text = staffModel.nama;
    tecTelepon.text = staffModel.telepon;
    tecPassword.text = staffModel.password;
    tecEmail.text = staffModel.email;

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
              controller: tecNIK,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.people),
                  hintText: "Nama staf"
              ),
              controller: tecNama,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: "Email"
              ),
              controller: tecEmail,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.security),
                  hintText: "Password"
              ),
              controller: tecPassword,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                hintText: "Nomor telepon"
              ),
              controller: tecTelepon,
            ),
            RaisedButton(
              color: Colors.deepOrange,
              onPressed: (){
                isc.updateStaf(context,
                    staffModel.id,
                    tecNIK.text.toString(),
                    tecNama.text.toString(),
                    tecEmail.text.toString(),
                    tecPassword.text.toString(),
                    tecTelepon.text.toString());

                // tecNIK.text="";
                // tecNama.text="";
                // tecEmail.text="";
                // tecPassword.text="";
                // tecTelepon.text="";
              },
              child: Text("Edit"),
              textColor: Colors.white,
            )

          ],
        ),
      ),
    );
  }
}
