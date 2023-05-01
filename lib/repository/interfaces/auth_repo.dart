import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository{
  Future<User?> getCurrentUser();
  Future<bool> logOut();
  Future<void> login({String email, String password});
  Future<void> loginWithSocial();
  Future<String> setToken();
}