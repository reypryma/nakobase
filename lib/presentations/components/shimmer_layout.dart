import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class ShimmerTextComponent extends StatefulWidget {
  final double width;
  final double height;

  const ShimmerTextComponent(
      {Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<ShimmerTextComponent> createState() => _ShimmerTextComponentState();
}

class _ShimmerTextComponentState extends State<ShimmerTextComponent> {
  bool enabled = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: blackTrans10,
        highlightColor: blackTrans30,
        child: Container(
          decoration: const BoxDecoration(
            color: kErrorRed,
              border: Border(bottom: BorderSide(color: Colors.black, width: 1.0))),
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}
