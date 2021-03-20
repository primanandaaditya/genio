import 'package:flutter/material.dart';
import 'package:manajemen/helper/databasehelper.dart';
import 'package:manajemen/home/homeview.dart';
import 'package:manajemen/staf/insert/insertstafview.dart';
import 'package:manajemen/staf/list/liststaf.dart';
import 'package:manajemen/user/list/listuser.dart';
import 'package:manajemen/views/login.dart';
import 'package:sqflite/sqflite.dart';

import 'helper/warna.dart';
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
        fontFamily: 'SG',
        appBarTheme: AppBarTheme(
          color: Warna.kuning,
        ),
        scaffoldBackgroundColor: Warna.hitam1,
        buttonColor: Colors.deepOrange,
        primaryColor: Warna.pink,
        backgroundColor: Warna.hitam1,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Warna.kuning,
          foregroundColor: Warna.hitam2,
          splashColor: Warna.kuning
        ),
        iconTheme: IconThemeData(
          color: Warna.pink
        ),
        hintColor: Warna.pink,


        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Warna.putih
          ),


          focusColor: Warna.kuning,
            // border: new OutlineInputBorder(
            //   borderRadius: const BorderRadius.all(
            //     const Radius.circular(15.0),
            //   ),
            // ),
            // filled: true,

            fillColor: Warna.hitam2),

      ),
      home: LoginView(),
    );
  }
}

DatabaseHelper databaseHelper;

