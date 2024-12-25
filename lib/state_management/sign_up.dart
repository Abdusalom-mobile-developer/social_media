import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends StateNotifier<bool>{
  SignUp() : super(false);

  Future<void> signUp() async{
    state = true;
    await Future.delayed(Duration(seconds: 2));
    state = false;
  }
}

final signUpProvider = StateNotifierProvider<SignUp, bool>((ref){
  return SignUp();
});