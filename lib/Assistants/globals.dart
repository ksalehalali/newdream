library route.globals;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String token = "";
const String baseURL = "https://dashcommerce.click68.com";
final LatLng initialPoint = new LatLng(29.376291619820897, 47.98638395798397);

String assetsDir = "assets/images/";
String assetsIconDir = "assets/icons/";
Color myHexColor = const Color(0xff01a9aa);
Color myHexColor1 = const Color(0xff10c2c2);
Color myHexColor2 = const Color(0xff1dd5d7);
Color myHexColor3 = const Color(0xff22dcdb);
Color myHexColor4 = const Color(0xff1cd3dc);
Color myHexColor5 = const Color(0xff0fbcbc);
final Map<int, Color> primaryColorMap = {
  50: myHexColor,
  100: myHexColor1,
  200: myHexColor2,
  300: myHexColor3,
  400: myHexColor4,
  500: myHexColor5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white,
};

final MaterialColor primaryColorSwatch = MaterialColor(myHexColor5.value, primaryColorMap);
