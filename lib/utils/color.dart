import 'package:flutter/material.dart';

const MaterialColor whiteGradient = MaterialColor(
  _whiteGradientPrimaryValue,
  <int, Color>{
    50: Color(_whiteGradientPrimaryValue),
    100: Color(0xFFe6e6e6),
    200: Color(0xFFcdcdcd),
    300: Color(0xFFb4b4b4),
    400: Color(0xFF9b9b9b),
    500: Color(0xFF828282),
    600: Color(0xFF696969),
    700: Color(0xFF505050),
    800: Color(0xFF373737),
    900: Color(0xFF141414),
    1000: Color(0xFF000000),
  },
);
const int _whiteGradientPrimaryValue = 0xFFffffff;
