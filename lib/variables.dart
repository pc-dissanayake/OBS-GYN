import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int bottomnavigationbarindex = 0;
DateTime LMP, DOC, EDD, ET1, ET2, GTD = DateTime.now();
String POG = "";

Color primaryfontcolor = Colors.white;
Color primaryColor = Color(0xFF6a1b9a);

TextStyle HomePageButtonTexts =
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);

TextStyle ButtonTextcolorforPrimary =
    TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500);

Color HomepagebuttonsiconColor = Color(0xff8e24aa);

LinearGradient gradient1 = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: [0.2, 0.8],
  colors: [Color(0xFF2196f3), Color(0xFFf50057)],
);
LinearGradient gradient2 = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: [0.2, 0.8],
  colors: [Color(0xFFbdc3c7), Color(0xFF536976)],
);
