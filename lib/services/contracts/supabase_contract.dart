import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseServiceContract{
  SupabaseClient init();
  bool checkSession();
  bool checkAuthUser();
}