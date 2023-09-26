

import 'package:flutter/material.dart';
import 'package:nakobase/presentations/pages/dashboard_screen.dart';
import 'package:nakobase/presentations/pages/login_page.dart';
import 'package:nakobase/presentations/pages/profile/avatar_upload_page.dart';
import 'package:nakobase/presentations/pages/profile_page.dart';
import 'package:nakobase/presentations/pages/register_page.dart';
import 'package:nakobase/presentations/pages/todo/create_todo_page.dart';
import 'package:nakobase/presentations/pages/todo/edit_todo_page.dart';
import 'package:nakobase/presentations/pages/todo/list_todo_page.dart';

class Routes{
  static Map<String, WidgetBuilder> getAll() => _routes;

// TodoModel
  static const String main_todo = 'todo_home';
  static const String dashboard = 'dashboard';
  static const String edit_todo = 'edit_todo_page';
  static const String create_todo = 'create_todo_page';

  // User
  static const String profile = 'profile';
  static const String login = 'login';
  static const String register = 'register';


  static const String avatar = 'avatar';





  static final Map<String, WidgetBuilder> _routes = {

      // Dashboard
      dashboard: (BuildContext context) => DashboardScreen(),

      avatar: (BuildContext context){
        var data = ModalRoute.of(context)!.settings.arguments as Map;
        if (data != null) {
          return Avatar(imageUrl: data['imgUrl'], onUpload: data['onUpload']);
        }else{
          throw ArgumentError('Invalid argument: cannot be null');
        }
      },

      // Gallery
      main_todo: (BuildContext context) => const ListTodoPage(),
      edit_todo: (BuildContext ctx) => const EditTodoPage(),
      create_todo: (BuildContext ctx) => const CreateTodoPage(),

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


