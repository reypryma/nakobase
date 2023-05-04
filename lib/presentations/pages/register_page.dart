import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/presentations/components/app_bar.dart';
import 'package:nakobase/presentations/components/app_button.dart';
import 'package:nakobase/presentations/components/text_input.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/extra/StringExtensions.dart';
import 'package:nakobase/utils/extra/text_style.dart';

import '../../data/nsimages.dart';
import '../../utils/colors.dart';
import '../../utils/extra/extra_commons.dart';
import '../../utils/styles.dart';
import '../routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool isPasswordMatch = false;
  bool isPasswordVisible = true;
  bool isPasswordIconVisible = false;
  bool isCPasswordVisible = true;
  bool isCPasswordIconVisible = false;
  bool isConfirmBtnEnable = false;

  TextEditingController passCtrl = TextEditingController();
  TextEditingController cPassCtrl = TextEditingController();

  FocusNode? pwdFocus;
  FocusNode? cPwdFocus;

  @override
  void initState() {
    super.initState();
    pwdFocus = FocusNode();
    cPwdFocus = FocusNode();
    init();
  }

  init() async {}

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    IconButton iconButtonPassword(){
      return IconButton(
          icon: isPasswordVisible ? const Icon(Icons.visibility_off, color: blackTrans90) : const Icon(Icons.visibility, color: blackTrans90),
          onPressed: () {
            isPasswordVisible = !isPasswordVisible;
            setState(() {});
          });
    }

    return Scaffold(
      appBar: customAppBar(
          title: LocaleKeys.signup.tr(),
          context: context,
          state: () {
            setState(() {});
          }),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(LocaleKeys.create_account.tr(),
                    style: textLato(context, 30, kDarkBgLight)),
                const SizedBox(height: 20),
                Text(LocaleKeys.name.tr(), style: boldTextStyle(color: black)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: successBG,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: icWhiteColor),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: buildInputDecoration(
                      name: LocaleKeys.input_name.tr(),
                      color: icWhiteColor,
                      iconColor: icWhiteColor,
                      prefixIcon: Icons.person_outline,
                    ),
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return LocaleKeys.enter_valid_username.tr();
                      }
                      if (!RegExp("^[a-zA-Z]*").hasMatch(name)) {
                        return LocaleKeys.enter_valid_username.tr();
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(LocaleKeys.email.tr(), style: boldTextStyle(color: black)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: successBG,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: icWhiteColor),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: buildInputDecoration(
                      name: LocaleKeys.input_email.tr(),
                      color: icWhiteColor,
                      iconColor: icWhiteColor,
                      prefixIcon: Icons.mail_outline,
                    ),
                    validator: (mail) {
                      if (mail == null || mail.isEmpty) {
                        return LocaleKeys.enter_valid_mail.tr();
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(mail)) {
                        return LocaleKeys.enter_valid_mail.tr();
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text('Password', style: boldTextStyle(color: black)),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.only(left: 16, bottom: 2, right: 8, top: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: icScaffoldBgColor,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passCtrl,
                    autofocus: true,
                    focusNode: pwdFocus,
                    textInputAction: TextInputAction.next,
                    obscureText: isPasswordVisible ? true : false,
                    style:
                        secondaryTextStyle(color: appBarBackgroundColorGlobal, size: 20),
                    decoration: passwordInput(
                        iconButton: iconForPasswordNoButton(isIconVisible: isPasswordIconVisible, iconButton: iconButtonPassword())),
                    onFieldSubmitted: (val) {
                      pwdFocus!.unfocus();
                      FocusScope.of(context).requestFocus(cPwdFocus);
                    },
                    onChanged: (val) {
                      isPasswordIconVisible = val.isEmptyOrNull ? false : true;
                      isConfirmBtnEnable = passCtrl.text.isEmptyOrNull ||
                              cPassCtrl.text.isEmptyOrNull
                          ? false
                          : true;
                      setState(() {});
                    },
                    validator: (val) {
                      if (val.isEmptyOrNull) {
                        return LocaleKeys.input_password.tr();
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                nakoAppButton(context, LocaleKeys.create_account.tr(), (){
                  Navigator.popAndPushNamed(context, Routes.login, arguments: LocaleKeys.login);
                }),
                const SizedBox(height: 40),
                Row(
                  children: [
                    const Expanded(child: Divider(endIndent: 10)),
                    Text(LocaleKeys.or.tr().toUpperCase(), style: secondaryTextStyle()),
                    const Expanded(child: Divider(indent: 10)),
                  ],
                ),
                const SizedBox(height: 20),
                AppButton(
                  color: Colors.white,
                  elevation: 0,
                  width: MediaQuery.of(context).size.width,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.googleIcon, height: 24, width: 24),
                      const SizedBox(width: 8),
                      Text("${LocaleKeys.signup.tr()} with Google", style: boldTextStyle()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
