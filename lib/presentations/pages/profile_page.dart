import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/presentations/components/circular.dart';
import 'package:nakobase/presentations/components/shimmer_layout.dart';
import 'package:nakobase/presentations/extensions/widget_extension.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/commons.dart';
import 'package:nakobase/utils/extra/CustomSnackBar.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';

import '../../core/models/profile.dart';
import '../../core/service_locator.dart';
import '../../utils/styles.dart';
import '../components/app_button.dart';
import '../components/dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User? currentUser;
  Profile? profile;
  bool isLoading = true;
  double hBox = 30;

  @override
  void initState() {
    init();
    super.initState();
  }

  // init() async {
  //   currentUser = authRepository.getCurrentUser();
  //   await profileRepository
  //       .getUserProfile()
  //       .then((value) => profile = value)
  //       .catchError((e) {
  //     print("profie: ${profile?.fullName}");
  //     return e;
  //   });
  // }

  init() async {
    profile = await profileRepository.getUserProfile().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget shimmeringInfo(String? infoProfile, {double? hWidth}) {
      return !isLoading
          ? Text(
        infoProfile ?? "not found",
        style: secondaryTextStyle(color: kDarkBgDark, size: 18),
      )
          : ShimmerTextComponent(
        width: hWidth ?? MediaQuery.of(context).size.width * .4,
        height: hBox,
      );
    }

    return Scaffold(
      backgroundColor: kTeal50,
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.profile.tr(),
                style: boldTextStyle(size: 25, color: icNavyBlueColor),
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? progressIndicator()
                  : Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        commonCachedNetworkImage(
                          // profile?.avatarUrl,
                          profile?.avatarUrl ?? '',
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        ).cornerRadiusWithClipRRect(45),
                        Positioned(
                          bottom: 10,
                          left: 100,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: SHPrimaryColor,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.camera_alt_outlined,
                                  color: white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ).center(),
              const SizedBox(
                height: 20,
              ),
              shimmeringInfo(profile?.fullName ?? 'Loading Username'),
              const SizedBox(height: 20),
              shimmeringInfo(profile?.website?? 'no website'),
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
