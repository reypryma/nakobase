
import 'package:nakobase/services/contracts/supabase_contract.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServiceImp implements SupabaseServiceContract {
  final supabaseClient = Supabase.instance.client;

  @override
  SupabaseClient init() {
    return supabaseClient;
  }

  void refreshSession() {
    supabaseClient.auth.refreshSession();
  }

  @override
  bool checkSession(){
    final session = supabaseClient.auth.currentSession;
    if (session != null) {
      final currentTime = DateTime.now();
      final expirationTimeStamp = session.expiresAt;
      final expirationTime = DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000);

      print('Expiration Time : ${expirationTimeStamp} so the expiration: ${expirationTime}, check: ${expirationTime.isAfter(currentTime)}');

      if(expirationTime.isAfter(currentTime)){
        print('refresh session');
        // refreshSession();
      }
      refreshSession();
      return true;
    }else{
      return false;
    }
  }
}
