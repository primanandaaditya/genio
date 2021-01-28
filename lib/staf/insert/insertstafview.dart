import 'package:flutter/material.dart';
import 'package:manajemen/staf/insert/insertStafController.dart';

insertStafController isc=insertStafController();
TextEditingController tecNIK=TextEditingController();
TextEditingController tecNama=TextEditingController();
TextEditingController tecEmail=TextEditingController();
TextEditingController tecPassword=TextEditingController();
TextEditingController tecTelepon=TextEditingController();

class InsertStafView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Staf"),),
      body: View(),
    );
  }
}

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                isc.addStaf(context,
                    tecNIK.text.toString(),
                    tecNama.text.toString(),
                    tecEmail.text.toString(),
                    tecPassword.text.toString(),
                    tecTelepon.text.toString());

                tecNIK.text="";
                tecNama.text="";
                tecEmail.text="";
                tecPassword.text="";
                tecTelepon.text="";
              },
              child: Text("Simpan"),
              textColor: Colors.white,
            )

          ],
        ),
      ),
    );
  }
}
