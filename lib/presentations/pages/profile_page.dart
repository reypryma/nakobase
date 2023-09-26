import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/presentations/components/circular.dart';
import 'package:nakobase/presentations/components/shimmer_layout.dart';
import 'package:nakobase/presentations/components/snackbar.dart';
import 'package:nakobase/presentations/components/text_input.dart';
import 'package:nakobase/presentations/extensions/widget_extension.dart';
import 'package:nakobase/presentations/pages/profile/avatar_upload_page.dart';
import 'package:nakobase/services/providers/profile_provider.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';
import 'package:provider/provider.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/models/profile.dart';
import '../../core/service_locator.dart';
import '../../utils/styles.dart';
import '../components/app_button.dart';
import '../components/dialog.dart';
import '../components/divider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User? currentUser;
  ProfileProvider? profileProvider;
  Profile? profile;
  bool isLoading = true;
  double hBox = 30;
  String? avatarProfile;

  TextEditingController usernameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

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
    profileProvider = p.Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider?.getCurrentProfile().whenComplete((){
      profile = profileProvider?.profile;
      avatarProfile = profile?.avatarUrl;
      setState(() {
        isLoading = false;
      });
    });
    // profile = await profileRepository.getUserProfile().whenComplete(() async {
    //   avatarProfile = profile?.avatarUrl;
    //   print('avatar profile $avatarProfile');
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget mInput(var mLabel, TextEditingController textController) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 10, 16),
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0.0),
            isDense: true,
            hintText: mLabel,
            border: InputBorder.none,
          ),
        ),
      );
    }

    /// Called when image has been uploaded to Supabase storage from within Avatar widget
    Future<void> _onUpload(String imageUrl) async {
      try {
        final userId = authRepository.getCurrentUser()!.id;
        await supabaseService.init().from('profiles').upsert({
          'id': userId,
          'avatar_url': imageUrl,
        });
        if (mounted) {
          context.showSnackBar(message: 'Updated your profile image!');
        }
      } on PostgrestException catch (error) {
        context.showErrorSnackBar(message: error.message);
      } catch (error) {
        context.showErrorSnackBar(message: 'Unexpected error has occurred');
      }
      if (!mounted) {
        return;
      }

      setState(() {
        avatarProfile = imageUrl;
      });
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
                  :
/*              Stack(
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
                              icon: Icon(Icons.camera_alt_outlined,
                                  color: icDarkBLue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ).center(),*/
                  Avatar(
                      imageUrl: avatarProfile ?? (profile?.avatarUrl ?? ''),
                      onUpload: _onUpload,
                    ).center(),
              buildDivider(isFull: true),
              !isLoading
                  ? Container(
                      decoration: boxDecorationRoundedWithShadow(8,
                          backgroundColor: Theme.of(context).cardColor),
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          mInput(profile?.fullName, usernameController),
                          const SizedBox(
                            height: 20,
                          ),
                          mInput(profile?.website ?? 'no website',
                              websiteController),
                        ],
                      ),
                    )
                  : ShimmerTextComponent(
                      width: MediaQuery.of(context).size.width * .4,
                      height: 300,
                    )
            ],
          )),
      bottomNavigationBar: AppButton(
        height: 50,
        width: 30,
        elevation: 2,
        text: LocaleKeys.update_profile.tr(),
        color: SHScaffoldDarkColor,
        textStyle: boldTextStyle(color: kBadgeColor),
        padding: const EdgeInsets.only(bottom: 16, top: 16),
        onTap: () async {
          await showConfirmDialog(
            context,
            'You want to?',
            onAccept: () async {
              Map<String, dynamic> data = {};
              if (usernameController.text.trim().isNotEmpty) {
                data['full_name'] = usernameController.text.trim();
              }
              if (websiteController.text.trim().isNotEmpty) {
                data['website'] = websiteController.text.trim();
              }
              print('the user sending $data');
              setState(() {isLoading = true;});
              if(data.isNotEmpty){
                await profileRepository
                    .updateUserInfo(data: data)
                    .then((value) => init());
              }
              setState(() {isLoading = false;});
              if (!mounted) {
                return;
              }
              showCustomSnackBar('Success', context, isError: false);
            },
          );
        },
      ),
    );
  }
}
