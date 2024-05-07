import 'package:flutter/material.dart';

class Layout{
  static const textFieldShadow = [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 10,
      spreadRadius: -1,
      offset: Offset(0, 3),
    ),
    BoxShadow(
      color: Colors.white,
      blurRadius: 25,
      offset: Offset(0, -3),
    ),
  ];
   static const blackAndWhiteShadow = [
    BoxShadow(
      color: Colors.black45,
      blurRadius: 10,
      spreadRadius: -5,
      offset: Offset(5, 5),
    ),
    BoxShadow(
      color: Colors.white,
      blurRadius: 25,
      offset: Offset(-5, -5),
    ),
  ];

}

