import 'package:flutter/material.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';
import 'package:nakobase/utils/extra/text_style.dart';

import '../../utils/colors.dart';

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
