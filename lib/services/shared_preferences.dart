import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {


  static Future<bool> checkSignIn() async {
    final SharedPreferences ref = await SharedPreferences.getInstance();

    return ref.getBool("isSignedIn") ?? false;
  }


  static Future<void> setSignIn() async {
    final SharedPreferences ref = await SharedPreferences.getInstance();

    ref.setBool("isSignedIn", true);
  }


  static Future<void> setSignOut() async {
    final SharedPreferences ref = await SharedPreferences.getInstance();

    ref.setBool("isSignedIn", false);
  }

  
}
