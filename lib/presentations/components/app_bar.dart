import 'package:flutter/material.dart';

import '../../data/language.dart';
import '../../utils/colors.dart';
import '../../utils/extra/text_style.dart';

AppBar customAppBar({required String title, required BuildContext context, required VoidCallback state}){
  return AppBar(
    title: Text(title),
    actions: [
      languageSetting(context, state)
    ],
  );
}

InkWell languageSetting(BuildContext context, VoidCallback state) {
  return InkWell(
      child: TextButton.icon(
        icon: const Icon(Icons.settings, color: scaffoldColorDark),
        onPressed: () async {
          await updateLanguage(context);
          state;
        }, label: Text(getISOLanguageInfo(Localizations.localeOf(context)) ?? 'English', style: textLato(context, 16, blackTrans95),),
      ),
    );
}