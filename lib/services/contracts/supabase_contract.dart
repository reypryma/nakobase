import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaServiceContract{
  Future<SupabaseClient> init();
}