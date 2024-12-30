import 'package:riverpod/riverpod.dart';

class TextFieldsObscureSignIn extends StateNotifier<bool> {
  TextFieldsObscureSignIn() : super(true);

  bool get value => state;

  void changeTheValue() {
    state = !state;
  }
}

class TextFieldsObscureSignUp extends StateNotifier<bool> {
  TextFieldsObscureSignUp() : super(true);
  
  bool get value => state;

  void changeTheValue() {
    state = !state;
  }
}

class TextFieldsObscureSignUp2 extends StateNotifier<bool> {
  TextFieldsObscureSignUp2() : super(true);
  
  bool get value => state;

  void changeTheValue() {
    state = !state;
  }
}

final textFieldsObscureSignInProvider = StateNotifierProvider<TextFieldsObscureSignIn, bool>((ref) {
  return TextFieldsObscureSignIn();
});

final textFieldsObscureSignUpProvider = StateNotifierProvider<TextFieldsObscureSignUp, bool>((ref) {
  return TextFieldsObscureSignUp();
});

final textFieldsObscureSignUp2Provider = StateNotifierProvider<TextFieldsObscureSignUp2, bool>((ref) {
  return TextFieldsObscureSignUp2();
});