
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:nakobase/presentations/extensions/widget_extension.dart';
import 'package:nakobase/utils/extra/StringExtensions.dart';

import '../../utils/constant.dart';

Widget commonSHCachedNetworkImage(
    String? url, {
      double? height,
      double? width,
      BoxFit? fit,
      AlignmentGeometry? alignment,
      bool usePlaceholderIfUrlEmpty = true,
      double? radius,
      Color? color,
    }) {
  if (url!.validate().isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      color: color,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return const SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.asset(
      url,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment ?? Alignment.center,
    ).cornerRadiusWithClipRRect(
      radius ?? defaultRadius,
    );
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius, Focus? focus}) {
  return Image.asset('images/dating/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center)
      .cornerRadiusWithClipRRect(radius ?? defaultRadius);
}
