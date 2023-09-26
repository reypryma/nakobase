import 'package:flutter/material.dart';
import 'package:nakobase/utils/styles.dart';

Container progressIndicator() {
  return Container(
    alignment: Alignment.center,
    child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        margin: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(8.0),
          child: const CircularProgressIndicator(
            color: primaryBlue,
            strokeWidth: 3,
          ),
        )),
  );
}
