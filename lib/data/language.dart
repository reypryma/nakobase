import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/utils/extra/text_style.dart';

import '../translations/iso_code.dart';
import '../translations/supported_locales.dart';

Future updateLanguage(BuildContext context) async {
  await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ListView(
            children: supportedLocales.map((locale) {
              return Padding(
                padding: EdgeInsets.only(
                    right: 16,
                    left: 16,
                    top: supportedLocales.indexOf(locale) == 0 ? 16 : 0),
                child: Card(
                  child: ListTile(
                    onTap: () async {
                      Navigator.pop(context);
                      await context.setLocale(locale);
                    },
                    leading: Localizations.localeOf(context).languageCode ==
                            locale.languageCode
                        ? const Icon(Icons.radio_button_checked)
                        : const Icon(Icons.radio_button_off),
                    title: Text(getISOLanguageInfo(locale) ?? 'English'),
                    trailing: Text(
                       getISOLanguageInfo(locale, nativeName: false) ?? 'English',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      });
}

String? getISOLanguageInfo(Locale locale, {bool nativeName = true}) {
    final s = isoLangs[locale.languageCode] ?? isoLangs['en'];

    return nativeName ? s!["nativeName"]!.split(",")
        .first : s!["name"]!.split(',').first;
  }
