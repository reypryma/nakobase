import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstant{

  static String supabaseDefaultUrl = dotenv.get('SUPABASE_URL');

  /// user auth
  static String authGoogle = '$supabaseDefaultUrl/auth/v1/callback';

  /// shared preferences keys
  static const String isLoggedIn = 'isLoggedIn';
  static const String userKey = 'userKey';


}