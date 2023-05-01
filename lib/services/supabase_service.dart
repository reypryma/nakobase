import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServiceImp implements SupabaServiceContract {
  final supabaseClient = Supabase.instance.client;

  @override
  Future<SupabaseClient> init() async {
    return supabaseClient;
  }
}
