import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTime();
  }


  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/login');
  }


  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/comfortable.png", height: 160, width: 160,),
            Padding(padding: EdgeInsets.only(top: 30),),
            Text("USER MANAGEMENT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          ],
        )
      ),
    );
  }
}