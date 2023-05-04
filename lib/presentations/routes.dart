

import 'package:flutter/material.dart';
import 'package:nakobase/presentations/pages/dashboard_screen.dart';
import 'package:nakobase/presentations/pages/gallery/create_gallery_page.dart';
import 'package:nakobase/presentations/pages/gallery/edit_gallery_page.dart';
import 'package:nakobase/presentations/pages/gallery/list_gallery_page.dart';
import 'package:nakobase/presentations/pages/login_page.dart';
import 'package:nakobase/presentations/pages/profile_page.dart';
import 'package:nakobase/presentations/pages/register_page.dart';

class Routes{
  static Map<String, WidgetBuilder> getAll() => _routes;

  static const String main_gallery = 'gallery_home';
  static const String dashboard = 'dashboard';
  static const String edit_gallery = 'edit_gallery_page';
  static const String create_gallery = 'create_gallery_page';

  // User
  static const String profile = 'profile';
  static const String login = 'login';
  static const String register = 'register';

  static final Map<String, WidgetBuilder> _routes = {

      // Dashboard
      dashboard: (BuildContext context) => DashboardScreen(),

      // Gallery
      main_gallery: (BuildContext context) => const ListGalleryPage(),
      edit_gallery: (BuildContext ctx) => const EditGalleryPage(),
      create_gallery: (BuildContext ctx) => const CreateGalleryPage(),

      login: (BuildContext ctx) {
        var data = ModalRoute.of(ctx)!.settings.arguments as String;
        if (data != null) {
          return LoginPage(title: data);
        } else {
          throw ArgumentError('Invalid argument: title cannot be null');
        }
      },
      profile: (BuildContext ctx) => const ProfilePage(),
      register: (BuildContext ctx) => const RegisterPage(),

  };
}


