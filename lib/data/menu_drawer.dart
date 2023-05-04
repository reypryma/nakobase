import 'package:flutter/material.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';


class TextMenu extends StatelessWidget {
  final String menuText;
  final bool isSelected;
  const TextMenu({Key? key, this.isSelected = false, required this.menuText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(menuText, style: isSelected ? primaryTextStyle(color: successBG, weight: FontWeight.w600) : secondaryTextStyle(color: primaryDarkColor));
  }
}

