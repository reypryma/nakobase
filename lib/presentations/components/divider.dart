import 'package:flutter/material.dart';
import 'package:nakobase/presentations/extensions/widget_extension.dart';

Widget buildDivider({bool isFull = false}) {
  return const Divider(color: Colors.grey, thickness: 1,).paddingLeft(isFull ? 0 : 16);
}
