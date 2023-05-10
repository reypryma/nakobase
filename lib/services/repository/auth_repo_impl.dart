import 'package:flutter/foundation.dart';
import 'package:nakobase/core/api_constant.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'interfaces/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface{
  SupabaseClient supabase = supabaseService.init();
  Session? session;

  @override
  User? getCurrentUser() {
    final user = supabase.auth.currentUser!;
    return user;
  }

  @override
  Future<bool> logOut() async {
    try {
      await supabase.auth.signOut().then((value) => session = null);
      // if(supabase.auth.currentSession != null){
      //   supabase.auth.setSession(null);
      // }
      return true;
    } on Exception {
      print('Error on logout $Exception');
      return false;
    }
  }


  @override
  Future<void> loginWithGoogle() async{
    await supabase.auth.signInWithOAuth(Provider.google,redirectTo: kIsWeb ? null : AppConstant.callBackURL);
  }

  @override
  Future<String?> setSession() async {
      supabase.auth.onAuthStateChange.listen((data) {
        session = data.session;
      });
      return supabase.auth.currentSession?.accessToken;
  }

  @override
  Future<void> loginWithEmail({required String email, required String password}) async {
    try {
      await supabase.auth.signInWithPassword(email: email,password: password);
    } on Exception catch (e) {
      print('failed to login $e');
      throw 'Exception $e';
    }
  }

  @override
  Future<void> signUpWithEmail({required String email, required String password, required String fullName}) async {
    try{
      await supabase.auth.signUp(email: email,password: password, data: {'full_name' : fullName});
      supabase.auth.onAuthStateChange.listen((event) {
        if (event.event == AuthChangeEvent.signedIn) {
           logOut();
        }
      });
    } catch (error) {
        throw 'Unexpected error occurred $error';
    }
  }
}