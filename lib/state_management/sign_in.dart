import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignIn extends StateNotifier<bool> {
  SignIn() : super(false);

  Future<void> signIn() async {
    state = true;
    await Future.delayed(Duration(seconds: 2));
    state = false;
  }
}

final signInProvider = StateNotifierProvider<SignIn, bool>((ref) {
  return SignIn();
});
