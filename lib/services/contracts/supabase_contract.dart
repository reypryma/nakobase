import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaServiceContract{
  SupabaseClient init();
  Future<bool> checkSession();
}