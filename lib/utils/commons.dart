import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nakobase/presentations/extensions/widget_extension.dart';
import '../data/nsimages.dart';
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
  return const EdgeInsets.symmetric(vertical: 14, horizontal: 16);
}

Widget inkWellWidget({Function()? onTap, required Widget child}) {
  return InkWell(onTap: onTap, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashColor: Colors.transparent, child: child);
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
        if (!usePlaceholderIfUrlEmpty) return const SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.network(url!, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset(AppImages.defaultAvatar, height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center);
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


Decoration boxDecorationDefault({
  BorderRadiusGeometry? borderRadius,
  Color? color,
  Gradient? gradient,
  BoxBorder? border,
  BoxShape? shape,
  BlendMode? backgroundBlendMode,
  List<BoxShadow>? boxShadow,
  DecorationImage? image,
}) {
  return BoxDecoration(
    borderRadius: (shape != null && shape == BoxShape.circle)
        ? null
        : (borderRadius ?? radius()),
    boxShadow: boxShadow ?? defaultBoxShadow(),
    color: color ?? Colors.white,
    gradient: gradient,
    border: border,
    shape: shape ?? BoxShape.rectangle,
    backgroundBlendMode: backgroundBlendMode,
    image: image,
  );
}



/*------------------ Setting Item Widget ------------------*/
class SettingItemWidget extends StatelessWidget {
  final String title;
  final double? width;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final Function? onTap;
  final EdgeInsets? padding;
  final int paddingAfterLeading;
  final int paddingBeforeTrailing;
  final Color? titleTextColor;
  final Color? subTitleTextColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Decoration? decoration;
  final double? borderRadius;
  final BorderRadius? radius;

  SettingItemWidget({
    required this.title,
    this.onTap,
    this.width,
    this.subTitle = '',
    this.leading,
    this.trailing,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.padding,
    this.paddingAfterLeading = 16,
    this.paddingBeforeTrailing = 16,
    this.titleTextColor,
    this.subTitleTextColor,
    this.decoration,
    this.borderRadius = 8,
    this.hoverColor,
    this.splashColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      borderRadius: radius ?? (BorderRadius.circular(borderRadius!)),
      hoverColor: hoverColor,
      splashColor: splashColor,
      child: Container(
        width: width,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: decoration ?? const BoxDecoration(),
        child: Row(
          children: [
            leading ?? const SizedBox(),
            if (leading != null) SizedBox(width: paddingAfterLeading.toDouble()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.validate(),
                  style: titleTextStyle ??
                      boldTextStyle(
                          color: titleTextColor ?? textPrimaryColorGlobal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.toDouble()).visible(subTitle.validate().isNotEmpty),
                if (subTitle.validate().isNotEmpty)
                  Text(
                    subTitle!,
                    style: subTitleTextStyle ??
                        secondaryTextStyle(
                          color: subTitleTextColor ?? textSecondaryColorGlobal,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ).expand(),
            if (trailing != null) SizedBox(width: paddingBeforeTrailing.toDouble(),),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}








/*------------------ Snackbar ------------------*/

Color sSnackbarColor(BuildContext context) => Theme.of(context).primaryColor.withOpacity(0.8); // Colors.blueGrey[600]!;
const double sSnackBarMaxWidth = 400;
const double sSnackbarHeight = 50.0;
const double sSnackbarBorderRadius = 25.0;
BoxShadow sSnackbarShadow = BoxShadow(
  color: Colors.black.withOpacity(0.2),
  blurRadius: 4,
  offset: const Offset(1, 1),
);
Color sSnackBarIcon = Colors.white;

TextStyle sSnackbarText(BuildContext context) => Theme.of(context).textTheme.bodyLarge!.copyWith(
  color: Colors.white.withOpacity(0.95),
);

EdgeInsets sSnackbarIconPadding = const EdgeInsets.only(top: 2);