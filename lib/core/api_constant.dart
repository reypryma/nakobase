import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstant{

  static String supabaseDefaultUrl = dotenv.get('SUPABASE_URL');
  static String supabaseKey = dotenv.get('SUPABASE_KEY');

  /// user auth
  static String authGoogle = '$supabaseDefaultUrl/auth/v1/callback';

  /// shared preferences keys
  static const String isLoggedIn = 'isLoggedIn';
  static const String userKey = 'userKey';

  ///ImagePath
  static const String image = 'images/';
  static const String imageTDM = 'images/tdm';

  ///supabase callback
  static const String callBackURL = 'io.supabase.nakobase://login-callback';

}