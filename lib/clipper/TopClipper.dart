
//Costom CLipper class with Path
import 'dart:ui';

import 'package:flutter/rendering.dart';

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    var controlPoint = Offset(10, size.height / 2);
    var endPoint = Offset(100, size.height-120);

    var cp = Offset(size.width -10, size.height/2);
    var ep = Offset(size.width, size.height);

    var path = new Path()
    ..lineTo(0, size.height)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
    ..lineTo(size.width-100, size.height-120)
      ..quadraticBezierTo(
          cp.dx, cp.dy, ep.dx, ep.dy)
    ..lineTo(size.width, 0)
    ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
