import 'package:flutter/material.dart';
import 'package:nakobase/utils/colors.dart';

void showSnackBard(BuildContext context, String textSnack){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPrimaryColor,
      duration: const Duration(seconds: 8),
      content: Text(
        textSnack,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(
            fontWeight: FontWeight.bold,
            color: lightBlack),
      ),
    ),
  );
}