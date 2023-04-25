import 'dart:io';

import 'package:flutter/material.dart';

const passwordLengthGlobal = 8;
const defaultRadius = 10.0;
const defaultSmallRadius = 6.0;

const textPrimarySizeGlobal = 16.00;
const textBoldSizeGlobal = 16.00;
const textSecondarySizeGlobal = 14.00;

bool enableAppButtonScaleAnimationGlobal = true;
int? appButtonScaleAnimationDurationGlobal;
ShapeBorder? defaultAppButtonShapeBorder;

var customDialogHeight = 140.0;
var customDialogWidth = 220.0;

double tabletBreakpointGlobal = 600.0;
double desktopBreakpointGlobal = 720.0;
double statisticsItemWidth = 230.0;
double defaultAppButtonElevation = 4.0;

Platform platform = Platform();
double? deviceWidth;
double? deviceHeight;
double? deviceShortestSide;
Orientation? deviceOrientation;


double menuWidth = 300; // deviceWidth * 0.6;
double menuWidthDesktop = 300;
double menuWidthTablet = 300;
bool hideScaffoldAppBar = false;

const double sGutterGap = 20.0;

class Config{
  /// APP COLORS
  static final Color primaryColor = HexColor("#5c5ff5");
  static final Color accentColor = HexColor("#5c5ffC");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}