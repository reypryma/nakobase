import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServiceImp implements SupabaseServiceContract {
  final supabaseClient = Supabase.instance.client;

  @override
  SupabaseClient init() {
    return supabaseClient;
  }

  @override
  bool checkSession(){
    final session = supabaseClient.auth.currentSession;
    if (session != null) {
      return true;
    }else{
      return false;
    }
  }
}
