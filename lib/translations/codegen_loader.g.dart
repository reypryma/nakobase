// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "AppTitle": "Supabase Application",
  "you_pushed_the_button": "You have pushed the button this many times:",
  "languages": {
    "english": "English",
    "indonesian": "Bahasa"
  }
};
static const Map<String,dynamic> id = {
  "AppTitle": "Aplikasi Supabase",
  "you_pushed_the_button": "Kamu telah menekan tombol sebanyak ini:",
  "languages": {
    "english": "Inggris",
    "indonesian": "Indonesia"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "id": id};
}
