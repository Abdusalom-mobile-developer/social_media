import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/models/user_info.dart';

class SharedPreferencesService {
  static storeUserInfo(String uid, String username, String email,
      String password, String profilePic) async {
    final SharedPreferences ref = await SharedPreferences.getInstance();

    UserFullInfo user = UserFullInfo(
      uid: "123",
      username: "JohnDoe",
      email: "john@example.com",
      password: "securePassword",
      profilePic: "profilePicUrl",
    );

    ref.setString("userInfo", user.toJson());
  }

  static Future<UserFullInfo> getUserInfo() async {
    final SharedPreferences ref = await SharedPreferences.getInstance();

    return UserFullInfo.fromJson(ref.getString("userInfo")!);
  }

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
