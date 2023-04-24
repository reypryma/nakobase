import 'package:flutter/material.dart';
import 'package:nakobase/utils/colors.dart';

import '../constant.dart';

TextStyle primaryTextStyle({int? size, Color? color, FontWeight? weight}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textPrimarySizeGlobal,
    color: color ?? textPrimaryColorGlobal,
    fontWeight: weight ?? FontWeight.normal,
  );
}

// Secondary Text Style
TextStyle secondaryTextStyle({int? size, Color? color, FontWeight? weight}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textSecondarySizeGlobal,
    color: color ?? textSecondaryColorGlobal,
    fontWeight: weight ?? FontWeight.normal,
  );
}

TextStyle boldTextStyle({int? size, Color? color, FontWeight? weight}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textBoldSizeGlobal,
    color: color ?? textPrimaryColorGlobal,
    fontWeight: weight ?? FontWeight.bold,
  );
}

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

/// returns Radius
BorderRadius radius([double? radius]) {
  return BorderRadius.all(radiusCircular(radius ?? defaultRadius));
}

/// returns Radius
Radius radiusCircular([double? radius]) {
  return Radius.circular(radius ?? defaultRadius);
}
