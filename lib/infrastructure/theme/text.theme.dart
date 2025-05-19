
import 'package:flutter/material.dart';

import 'colors.theme.dart';

lightTextStyle({required fontSize, color, height}) {
  return TextStyle(fontSize: fontSize, color: color ?? ColorsTheme.colBlack, fontWeight: FontWeight.w400, height: height,letterSpacing: 1);
}

regularTextStyle({required fontSize, color, height}) {
  return TextStyle(fontSize: fontSize, color: color ?? ColorsTheme.colBlack, fontWeight: FontWeight.w500, height: height,letterSpacing: 1.2);
}

semiBoldTextStyle({required fontSize, color, height}) {
  return TextStyle(fontSize: fontSize, color: color ?? ColorsTheme.colBlack, fontWeight: FontWeight.w600, height: height,letterSpacing: 1.2);
}

boldTextStyle({required fontSize, color, height}) {
  return TextStyle(fontSize: fontSize, color: color ?? ColorsTheme.colBlack, fontWeight: FontWeight.w700, height: height,letterSpacing: 1.2);
}

extraBoldTextStyle({required fontSize, color, height}) {
  return TextStyle(fontSize: fontSize, color: color ?? ColorsTheme.colBlack, fontWeight: FontWeight.w900, height: height,letterSpacing: 1.2);
}

appBarTextStyle({fontSize, color}) {
  return TextStyle(fontSize: fontSize ?? dimen20, color: color ?? Colors.black, fontWeight: FontWeight.w700);
}

spanTextStyle({required fontSize, color, height}) {
  return TextStyle(fontSize: fontSize, color: color ?? ColorsTheme.colBlack, fontWeight: FontWeight.w400, height: height,letterSpacing: 0.8,wordSpacing: 2);
}

// font size
var dimen8 = 8.0;
var dimen9 = 9.0;
var dimen10 = 10.0;
var dimen11 = 11.0;
var dimen12 = 12.0;
var dimen13 = 13.0;
var dimen14 = 14.0;
var dimen15 = 15.0;
var dimen16 = 16.0;
var dimen17 = 17.0;
var dimen18 = 18.0;
var dimen19 = 19.0;
var dimen20 = 20.0;
var dimen21 = 21.0;
var dimen22 = 22.0;
var dimen23 = 23.0;
var dimen24 = 24.0;
var dimen25 = 25.0;
var dimen26 = 26.0;
var dimen27 = 27.0;
var dimen28 = 28.0;
var dimen29 = 29.0;
var dimen30 = 30.0;
var dimen31 = 31.0;
var dimen32 = 32.0;
var dimen50 = 50.0;
