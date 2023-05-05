import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository{
  Future<User?> getCurrentUser();
  Future<bool> logOut();
  Future<void> loginWithEmail({required String email,required String password});
  Future<void> signUpWithEmail ({required String email,required String password, required String fullName});
  Future<void> loginWithGoogle();
  Future<String> setSession();
}