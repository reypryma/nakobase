import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/data/nsimages.dart';
import 'package:nakobase/presentations/components/app_bar.dart';
import 'package:nakobase/presentations/components/app_button.dart';
import 'package:nakobase/presentations/components/snackbar.dart';
import 'package:nakobase/presentations/components/text_input.dart';
import 'package:nakobase/presentations/routes.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/extra/CustomSnackBar.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key? key, required this.title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool showPassword = false;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
          title: widget.title.tr(),
          context: context,
          state: () {
            setState(() {});
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kTeal50,
                    border: Border.all(width: .5, color: kTeal100)
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: black),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: buildInputDecoration(
                      name: LocaleKeys.input_email.tr(),
                      color: blackTrans90,
                      iconColor: blackTrans90,
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
                TextFormField(
                  focusNode: passwordNode,
                  controller: passwordController,
                  autofocus: false,
                  obscureText: showPassword ? false : true,
                  onFieldSubmitted: (term) {
                    passwordNode.unfocus();
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        showPassword = !showPassword;
                        setState(() {});
                      },
                      child: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                          color: blackTrans90),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: blackTrans30)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: blackTrans30)),
                    labelStyle: secondaryTextStyle(size: 14),
                    labelText: LocaleKeys.Password.tr(),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    maxLines: 2,
                    text: TextSpan(
                      text: LocaleKeys.dont_have_account.tr(args: ['Nako Base']),
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                            text: LocaleKeys.signup.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.pushNamed(context, Routes.register);
                            }
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                nakoAppButton(context, LocaleKeys.login_to_continue.tr(), () async {
                  try {
                    // print('email ${emailController.text.trim()}, password ${passwordController.text.trim()}');
                    await authRepository.loginWithEmail(email: emailController.text.trim(), password: passwordController.text.trim()).then((value){
                                        showCustomSnackBar('Success to login', context, isError: false);
                                        Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false);
                                      }).onError((error, stackTrace){
                                        showCustomSnackBar("$error", context, );
                                      });
                  } catch (e) {
                    print(e);
                  }
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
                  onTap: () async {
                    try {
                      await authRepository.loginWithGoogle().whenComplete(() async{
                        // showCustomSnackBar('Success to login', context, isError: false);
                        Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false);
                        setState(() { });
                        if(supabaseService.checkSession()){

                        }else{
                          showCustomSnackBar('Error', context, );
                        }
                      });
                      if (!mounted) {
                        return;
                      }
                    } catch (e) {
                      showCustomSnackBar(LocaleKeys.login, context, isError: false);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.googleIcon, height: 24, width: 24),
                      const SizedBox(width: 8),
                      Text("${LocaleKeys.login.tr()} with Google", style: boldTextStyle()),
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
