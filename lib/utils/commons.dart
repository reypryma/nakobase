import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'extra/StringExtensions.dart';

import 'colors.dart';
import 'constant.dart';
import 'extra/extra_commons.dart';

Widget dotIndicator(list, i) {
  return SizedBox(
    height: 16,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        list.length,
            (ind) {
          return Container(
            height: 8,
            width: 8,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: i == ind ? Colors.white : Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(defaultRadius)),
          );
        },
      ),
    ),
  );
}

InputDecoration inputDecoration(BuildContext context, {String? label, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    alignLabelWithHint: true,
    filled: true,
    isDense: true,
    labelText: label ?? "Sample Text",
    labelStyle: primaryTextStyle(),
  );
}

extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this ?? value;
}


EdgeInsets dynamicAppButtonPadding(BuildContext context) {
  return EdgeInsets.symmetric(vertical: 14, horizontal: 16);
}

Widget inkWellWidget({Function()? onTap, required Widget child}) {
  return InkWell(onTap: onTap, child: child, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashColor: Colors.transparent);
}

Widget commonCachedNetworkImage(
    String? url, {
      double? height,
      double? width,
      BoxFit? fit,
      AlignmentGeometry? alignment,
      bool usePlaceholderIfUrlEmpty = true,
      double? radius,
    }) {
  if (url != null && url.isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.network(url!, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('images/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center);
}

List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? Colors.grey.withOpacity(0.2),
      blurRadius: blurRadius ?? 4.0,
      spreadRadius: spreadRadius ?? 1.0,
      offset: offset,
    )
  ];
}
