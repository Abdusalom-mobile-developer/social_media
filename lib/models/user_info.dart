import 'dart:convert';

class UserFullInfo {
  String uid, username, email, password, profilePic;

  UserFullInfo({
    required this.uid,
    required this.username,
    required this.email,
    required this.password,
    required this.profilePic,
  });

  String toJson() {
    return jsonEncode({
      "uid": uid,
      "username": username,
      "email": email,
      "password": password,
      "profilePic": profilePic,
    });
  }

  factory UserFullInfo.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return UserFullInfo(
      uid: map["uid"],
      username: map["username"],
      email: map["email"],
      password: map["password"],
      profilePic: map["profilePic"],
    );
  }
}
