import 'package:flutter/cupertino.dart';
import 'package:nakobase/core/models/profile.dart';
import 'package:nakobase/core/service_locator.dart';

class ProfileProvider extends ChangeNotifier{
  Profile? _profile;

  Profile? get profile => _profile;

  set profile(Profile? value) {
    _profile = value;
  }

  Future<void> getCurrentProfile() async{
    try {
      profile = await profileRepository.getUserProfile();
      print('get profile provider $profile');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

}