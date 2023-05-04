import 'package:flutter/material.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';

class ListGalleryPage extends StatefulWidget {
  const ListGalleryPage({Key? key}) : super(key: key);

  @override
  State<ListGalleryPage> createState() => _ListGalleryPageState();
}

class _ListGalleryPageState extends State<ListGalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('List Gallery', style: boldTextStyle(size: 25, color: icNavyBlueColor),),
    );
  }
}
