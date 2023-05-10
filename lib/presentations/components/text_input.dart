import 'package:flutter/material.dart';
import 'package:nakobase/utils/constant.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';
import 'package:nakobase/utils/extra/text_style.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

InputDecoration buildInputDecoration(
    {String? name,
    Color? color,
    IconData? prefixIcon,
    Color? iconColor,
    Color? errorColor}) {
  return InputDecoration(
      hintText: name,
      errorStyle: secondaryTextStyle(color: errorColor ?? kDarkPriceColor),
      hintStyle: TextStyle(color: color),
      prefixIcon: Icon(
        prefixIcon,
        color: iconColor,
        size: 20,
      ),
      border: InputBorder.none);
}

InputDecoration passwordInput(
    {String? name,
    Color? color,
    Color? iconColor,
    Color? errorColor,
    required Widget iconButton}) {
  return InputDecoration(
      hintText: name,
      contentPadding: const EdgeInsets.only(left: 8, top: 8),
      errorStyle: secondaryTextStyle(color: errorColor ?? kDarkPriceColor),
      hintStyle: TextStyle(color: color),
      suffixIcon: iconButton,
      border: InputBorder.none);
}

Widget iconForPassword(
    {bool isTextVisible = false, bool isIconVisible = false}) {
  return isIconVisible
      ? IconButton(
          icon: isTextVisible
              ? const Icon(Icons.visibility_off, color: secProgressColor)
              : const Icon(Icons.visibility, color: successIcon),
          onPressed: () {},
        )
      : const SizedBox.shrink();
}

Widget iconForPasswordNoButton(
    {bool isTextVisible = false, bool isIconVisible = false, required IconButton iconButton}) {
  return isIconVisible
      ? iconButton
      : const SizedBox.shrink();
}

InputDecoration inputDecoration(BuildContext context, {String? hintText, InputBorder? inputBorder}) {
  return InputDecoration(
    border: inputBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius)),
    hintText: hintText ?? 'Loading',
    hintStyle: secondaryTextStyle(color: Colors.grey),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ev_primary_color), borderRadius: BorderRadius.circular(defaultRadius)),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(defaultRadius)),
  );
}

/// rounded box decoration with shadow
Decoration boxDecorationRoundedWithShadow(
    int radiusAll, {
      Color backgroundColor = kLightPrimary,
      Color? shadowColor,
      double? blurRadius,
      double? spreadRadius,
      Offset offset = const Offset(0.0, 0.0),
      LinearGradient? gradient,
    }) {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(
      shadowColor: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    ),
    color: backgroundColor,
    gradient: gradient,
    borderRadius: radius(radiusAll.toDouble()),
  );
}

/// default box shadow
List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}
