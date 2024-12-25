import 'package:riverpod/riverpod.dart';

class TextFieldsObscureSignIn extends StateNotifier<bool> {
  TextFieldsObscureSignIn() : super(true);

  void changeTheValue() {
    state = !state;
  }
}

class TextFieldsObscureSignUp extends StateNotifier<bool> {
  TextFieldsObscureSignUp() : super(true);

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
