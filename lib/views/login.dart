import 'package:flutter/material.dart';
import 'package:manajemen/staf/insert/insertStafController.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController tcEmail = TextEditingController();
TextEditingController tcPassword = TextEditingController();

insertStafController i = insertStafController();


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // i.insertStaf(context, "20001", "Dewa", "dewa@genio.co.id", "merah", "0011");
    // i.insertStaf(context, "20002", "Dewb", "dewa@genio.co.id", "merah", "0011");
    // i.insertStaf(context, "20003", "Dewc", "dewa@genio.co.id", "merah", "0011");
    // i.insertStaf(context, "20004", "Dewd", "dewa@genio.co.id", "merah", "0011");


    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
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
        key: _formKey,
        child: ListView(
          children: <Widget>[

            TextFormField(
              controller: tcEmail,
            ),
            TextFormField(
              controller: tcPassword,
              obscureText: true,
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/liststaf');
              },
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text("Login"),
            )

          ],
        ),
      )
    );
  }
}
