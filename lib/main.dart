import 'package:flutter/material.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/home/homeview.dart';
import 'package:manajemen/staf/insert/insertstafview.dart';
import 'package:manajemen/staf/list/liststaf.dart';
import 'package:manajemen/user/list/listuser.dart';
import 'package:manajemen/views/login.dart';
import 'package:sqflite/sqflite.dart';

import 'user/insert/insertuserview.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/liststaf': (context) => ListStafView(),
        '/addstaf': (context) => InsertStafView(),
        '/adduser': (context) => InsertUserView(),
        '/listuser': (context) => ListUserView(),
        '/home': (context) => HomeView(),
        '/login': (context) => LoginView()
      },
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginView(),
    );
  }
}

DatabaseHelper databaseHelper;

