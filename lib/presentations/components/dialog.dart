import 'package:flutter/material.dart';
import 'package:nakobase/utils/extra/StringExtensions.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';

Future<bool?> showConfirmDialog<bool>(
    context,
    String title, {
      String positiveText = 'Yes',
      String negativeText = 'No',
      Color? buttonColor,
      Color? barrierColor,
      bool? barrierDismissible,
      Function? onAccept,
    }) async {
  return showDialog(
    context: context,
    // barrierDismissible: barrierDismissible ?? false,
    builder: (_) => AlertDialog(
      title: Text(title.validate(), style: primaryTextStyle()),
      actions: <Widget>[
        SimpleDialogOption(
          child: Text(negativeText.validate(), style: secondaryTextStyle()),
          onPressed: () {
            Navigator.pop(_, false);
          },
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(_, true);

            onAccept?.call();
          },
          child: Text(
            positiveText.validate(),
            style: primaryTextStyle(
                color: buttonColor ?? Theme.of(_).primaryColor),
          ),
        ),
      ],
    ),
  );
}