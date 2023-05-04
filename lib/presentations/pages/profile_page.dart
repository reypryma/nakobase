import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(LocaleKeys.profile.tr(), style: boldTextStyle(size: 25, color: icNavyBlueColor),),
    );
  }
}
