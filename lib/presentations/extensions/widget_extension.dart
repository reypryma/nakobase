import 'package:flutter/material.dart';

extension WidgetExtension on Widget?{
  /// add custom corner radius each side
  ClipRRect cornerRadiusWithClipRRectOnly({
    int bottomLeft = 0,
    int bottomRight = 0,
    int topLeft = 0,
    int topRight = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft.toDouble()),
        bottomRight: Radius.circular(bottomRight.toDouble()),
        topLeft: Radius.circular(topLeft.toDouble()),
        topRight: Radius.circular(topRight.toDouble()),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// return padding left
  Padding paddingLeft(double left) {
    return Padding(padding: EdgeInsets.only(left: left), child: this);
  }


  /// add corner radius
  ClipRRect cornerRadiusWithClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  Widget center({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }

  Widget visible(bool visible, {Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? const SizedBox());
  }

  /// add Expanded to parent widget
  Widget expand({flex = 1}) => Expanded(flex: flex, child: this!);

}