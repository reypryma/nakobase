import 'package:nakobase/core/models/profile.dart';

abstract class ProfileRepositoryInterface{
  Future<Profile?> getUserProfile();
  Future<void> updateUserInfo({required Map data});
}