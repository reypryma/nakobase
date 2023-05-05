import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/core/api_constant.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/repository/interfaces/auth_repo.dart';
import 'package:nakobase/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl extends AuthRepository{
  SupabaseClient supabase = supabaseService.init();

  User? user;
  Session? session;

  @override
  Future<User?> getCurrentUser() async {
    final user = supabase.auth.currentUser!;
    return user;
  }

  @override
  Future<bool> logOut() async {
    try {
      await supabase.auth.signOut();
    } on Exception catch (e) {
      return false;
    }
    return true;
  }


  @override
  Future<void> loginWithGoogle() async{
    await supabase.auth.signInWithOAuth(Provider.google,redirectTo: kIsWeb ? null : AppConstant.callBackURL);
  }

  @override
  Future<String> setSession() {
    // TODO: implement setToken
    throw UnimplementedError();
  }

  @override
  Future<void> loginWithEmail({required String email, required String password}) async {
    try {
      await supabase.auth.signInWithPassword(email: email,password: password);
    } on Exception catch (e) {
      throw 'Exception $e';
    }
  }

  @override
  Future<void> signUpWithEmail({required String email, required String password, required String fullName}) async {
    try{
      await supabase.auth.signUp(email: email,password: password, data: {'full_name' : fullName});
    } catch (error) {
        throw 'Unexpected error occurred $error';
    }
  }
}

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}