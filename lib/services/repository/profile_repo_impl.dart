import 'package:flutter/foundation.dart';
import 'package:nakobase/core/models/profile.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/services/repository/interfaces/profile_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepositoryInterface{
  // final user = supabaseService.init().auth.currentUser!;

  @override
  Future<Profile?> getUserProfile() async{
    try {
      User? userId = authRepository.getCurrentUser();
      final data = await supabaseService.init().from('profiles')
          .select().eq('id', userId!.id).single();
      if (kDebugMode) {
        print("get profile: $data");
      }
      return Profile.fromJson(data);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserInfo({required Map data}) async{
    User? userId = authRepository.getCurrentUser();
     try {
       await supabaseService.init().from('profiles')
          .update(data).match({'id': userId!.id});
     } on Exception catch (e) {
       rethrow;
     }
  }

}