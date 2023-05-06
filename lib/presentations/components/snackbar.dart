import 'package:flutter/material.dart';
import 'package:nakobase/presentations/responsive_helper.dart';

import '../../utils/colors.dart';

class Dimensions {
  static const double FONT_SIZE_EXTRA_SMALL = 10.0;
  static const double FONT_SIZE_SMALL = 12.0;
  static const double FONT_SIZE_DEFAULT = 14.0;
  static const double FONT_SIZE_LARGE = 16.0;
  static const double FONT_SIZE_EXTRA_LARGE = 18.0;
  static const double FONT_SIZE_OVER_LARGE = 24.0;
  static const double FONT_SIZE_MAX_LARGE = 30.0;

  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;
  static const double PADDING_SIZE_LARGE = 20.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;

  static const double RADIUS_SIZE_DEFAULT = 8.0;
  static const double RADIUS_SIZE_TEN = 10.0;
  static const double RADIUS_SIZE_LARGE = 20.0;

  //message length
  static const int MESSAGE_INPUT_LENGTH = 250;
  static const double WEB_SCREEN_WIDTH = 1170.0;
}


extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = successIcon,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

void showCustomSnackBar(String message, BuildContext context, {bool isError = true}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final width = MediaQuery.of(context).size.width;
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(key: UniqueKey(), content: Text(message, overflow: TextOverflow.ellipsis, maxLines: 1),
      margin: ResponsiveHelper.isDesktop(context) ?  EdgeInsets.only(
        right: width * 0.75, bottom: Dimensions.PADDING_SIZE_LARGE, left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ) : const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      behavior: SnackBarBehavior.floating ,
      dismissDirection: DismissDirection.down,
      backgroundColor: isError ? Colors.red : Colors.green)
  );
}