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
  },
  "login_to_continue": "Login to Continue",
  "create_account": "Create Account",
  "dont_have_account": "don't have {} account?  ",
  "already_have_account": "Have {} account?  ",
  "welcome_back": "Welcome Back",
  "google": "Google",
  "login": "Login",
  "signup": "Sign Up",
  "logout": "Logout",
  "profile": "Profile",
  "add_gallery": "Add Gallery",
  "Gallery": "Gallery",
  "delete_gallery": "Delete Gallery",
  "delete": "Delete",
  "create": "Create",
  "Update": "Update",
  "name": "Name",
  "email": "Email",
  "Password": "Password",
  "or": "or",
  "submit": "Submit",
  "input_email": "input your email",
  "input_password": "input your password",
  "input_name": "input your name",
  "enter_valid_mail": "Enter Valid Mail",
  "enter_valid_username": "Enter Valid Username",
  "wrong_password": "Incorrect password"
};
static const Map<String,dynamic> id = {
  "AppTitle": "Aplikasi Supabase",
  "you_pushed_the_button": "Kamu telah menekan tombol sebanyak ini:",
  "languages": {
    "english": "Inggris",
    "indonesian": "Indonesia"
  },
  "login_to_continue": "Masuk untuk melanjutkan",
  "create_account": "Buat Akun",
  "dont_have_account": "tidak punya akun {}?  ",
  "already_have_account": "sudah ada {}?  ",
  "welcome_back": "Selamat Datang Kembali",
  "google": "Google",
  "login": "Masuk",
  "signup": "Daftar",
  "logout": "Keluar",
  "profile": "Profil",
  "add_gallery": "Tambah Galeri",
  "gallery": "Galeri",
  "delete_gallery": "Delete Galeri",
  "delete": "Hapus",
  "create": "Buat",
  "update": "Perbarui",
  "name": "Nama",
  "email": "Email",
  "Password": "Kata sandi",
  "or": "atau",
  "submit": "Kirim",
  "input_email": "masukkan email",
  "input_password": "masukkan password",
  "input_name": "masukkan username",
  "enter_valid_mail": "masukkan email yang valid",
  "enter_valid_username": "Format Username Salah",
  "wrong_password": "Password tidak cocok"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "id": id};
}
