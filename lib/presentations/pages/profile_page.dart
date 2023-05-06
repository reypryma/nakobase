import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/presentations/extensions/widget_extension.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/commons.dart';
import 'package:nakobase/utils/extra/CustomSnackBar.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';

import '../../utils/styles.dart';
import '../components/app_button.dart';
import '../components/dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTeal50,
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.profile.tr(), style: boldTextStyle(size: 25, color: icNavyBlueColor),),
              const SizedBox(height: 30,),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  commonCachedNetworkImage(
                    '',
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ).cornerRadiusWithClipRRect(45),
                ],
              ).center(),
            ],
          )),
      bottomNavigationBar: AppButton(
        height: 50,
        width: 30,
        elevation: 2,
        text: 'Update User',
        color: SHScaffoldDarkColor,
        textStyle: boldTextStyle(color: kBadgeColor),
        padding: const EdgeInsets.only(bottom: 16, top: 16),
        onTap: () async {
          await showConfirmDialog(
            context,
            'You want to?',
            onAccept: () {
              customSnackBar(context, 'Success');
            },
          );
        },
      ),
    );
  }
}
