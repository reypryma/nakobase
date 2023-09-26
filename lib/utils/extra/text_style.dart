import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../constant.dart';

TextStyle textLato(BuildContext context, double? size, Color? color) {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: size ?? 14,
      color: color ?? primaryDark,
      letterSpacing: 0,
    ),
  );
}


TextTheme lightTextTheme(BuildContext context) {
  return GoogleFonts.latoTextTheme(
    Theme
        .of(context)
        .textTheme,
  ).copyWith(
    //bodyLarge: TextStyle(fontSize: 18, color: kSecondaryDarkTextColor),
    bodyLarge: textLato(context, 18, kPrimaryDarkTextColor),
    //bodyMedium: TextStyle(fontSize: 16, color: kSecondaryDarkTextColor),
    bodyMedium: textLato(context, 16, kPrimaryDarkTextColor),
    // labelLarge: TextStyle(
    //     fontSize: 16,
    //     color: kPrimaryLightTextColor,
    //     fontWeight: FontWeight.bold),
    labelLarge: textLato(context, 16, kPrimaryLightTextColor),

    // titleLarge: TextStyle(fontSize: 18, color: kPrimaryDarkTextColor),
    titleLarge: textLato(context, 18, kPrimaryDarkTextColor),
    //headlineSmall: TextStyle(fontSize: 24, color: kPrimaryDarkTextColor),
    headlineSmall: textLato(context, 24, kPrimaryDarkTextColor),
    //headlineMedium: TextStyle(fontSize: 34, color: kPrimaryDarkTextColor),
    headlineMedium: textLato(context, 34, kPrimaryDarkTextColor),
    //displaySmall: TextStyle(fontSize: 44, color: kPrimaryDarkTextColor),
    displaySmall: textLato(context, 44, kPrimaryDarkTextColor),
    //displayMedium: TextStyle(fontSize: 54, color: kPrimaryDarkTextColor),
    displayMedium: textLato(context, 54, kPrimaryDarkTextColor),
    //displayLarge: TextStyle(fontSize: 64, color: kPrimaryDarkTextColor),
    displayLarge: textLato(context, 64, kPrimaryDarkTextColor),
    //titleMedium: TextStyle(fontSize: 16, color: kSecondaryDarkTextColor),
    titleMedium: textLato(context, 16, kPrimaryDarkTextColor),
    // titleSmall: TextStyle(fontSize: 14.0, color: kSecondaryDarkTextColor),
    titleSmall: textLato(context, 14.0, kPrimaryDarkTextColor),
    //bodySmall: TextStyle(fontSize: 12.0, color: kSecondaryDarkTextColor),
    bodySmall: textLato(context, 12.0, kPrimaryDarkTextColor),

    // labelSmall: TextStyle(
    //     fontSize: 10.0, color: kSecondaryDarkTextColor, letterSpacing: 0),
    labelSmall: textLato(context, 10.0, kPrimaryDarkTextColor),
  );
}


//Change these colors to as your own app needs
//Accent Color is the subtle colors of the primary color.
//Primary Color and Accent Color
// const kPrimaryColor = Color(0xff333E48);
final kPrimaryColor = primaryColor;
// final kAccentColor = Color(0xFF465058);
final kAccentColor = accentColor;

//Light Background Colors - Scaffold BG Color
const kLightBgColor = Color(0xfff5f5f5);

//Dark Background Colors - Scaffold BG Color
const kDarkBgColor = Color(0xFF2B2B2B);

//Light, dark and fade colors
const kLightColor = Colors.white;
const kDarkColor = Color(0xFF282828);
const kFadeColor = Color(0xFFB0B0B0);
const kBottomBarUnselectedColor = Color(0xFFF3EBEB);

//Other Colors
const kGreenColor = Colors.green;

//Primary Text Colors
const kPrimaryLightTextColor = Colors.white;
const kPrimaryDarkTextColor = Color(0xFF282828);
const kPrimaryFadeTextColor = Color(0xFFB4B2B2);

//Price Text Colors
const kPriceColor = Color(0xFFB12704);
const kDarkPriceColor = Color(0xFFF7CE19);

//Change these values to your own app needs
//Gradient Color For Product Offer and Coupons
final kGradientColor1 = gradientColor1;
final kGradientColor2 = gradientColor2;

/// APP COLORS
final Color primaryColor = HexColor("#5c5ff5");
final Color accentColor = HexColor("#5c5ffC");

///App Gradient Colors
final Color gradientColor1 = HexColor("#B12704");
final Color gradientColor2 = HexColor("#F75463");
//Card BG Color related to Primary Color
final kLightCardBgColor = kPrimaryColor.withOpacity(0.1);
const kDarkCardBgColor = Color(0xFF3D3C3C);
