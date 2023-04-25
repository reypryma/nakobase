import 'package:flutter/material.dart';
import 'package:nakobase/utils/constant.dart';

import '../commons.dart';
import '../responsive.dart';

SnackBar customSnackBar(BuildContext context, String message, [IconData? icon, bool fixedNavigationMenu = true]) {
  // bool fixedNavigationMenu = true;
  List<Widget> row = [];
  if (icon != null) {
    row.add(
      Padding(
        padding: sSnackbarIconPadding,
        child: Icon(
          icon,
          size: 20,
          color: sSnackBarIcon,
        ),
      ),
    );
    row.add(
      const SizedBox(
        width: 10,
      ),
    );
  }
  row.add(
    Text(
      message,
      style: sSnackbarText(context),
    ),
  );

  return SnackBar(
    margin: ((Responsive().deviceType() == "desktop" && fixedNavigationMenu)
        ? EdgeInsets.fromLTRB((menuWidthDesktop + sGutterGap), sGutterGap, sGutterGap, sGutterGap)
        : const EdgeInsets.all(sGutterGap)),
    content: GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: sSnackbarHeight,
            width: ((deviceWidth! - 100) > sSnackBarMaxWidth) ? sSnackBarMaxWidth : (deviceWidth! - 100),
            decoration: BoxDecoration(
              color: sSnackbarColor(context),
              boxShadow: [sSnackbarShadow],
              borderRadius: BorderRadius.circular(sSnackbarBorderRadius),
            ),
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
    duration: const Duration(milliseconds: 2000),
    padding: const EdgeInsets.all(0),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(sSnackbarBorderRadius),
    ),
  );
}