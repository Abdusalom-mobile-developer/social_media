import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/services/logger.dart';

class SignInState {
  final bool isSignedIn;
  final bool isWorking;

  SignInState({required this.isSignedIn, required this.isWorking});

  SignInState copyWith({bool? isSignedIn, bool? isWorking}) {
    return SignInState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isWorking: isWorking ?? this.isWorking,
    );
  }
}

class SignInProvider extends StateNotifier<SignInState> {
  SignInProvider() : super(SignInState(isSignedIn: false, isWorking: false));

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get user => _auth.currentUser?.uid;

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isWorking: true);

    await Future.delayed(const Duration(seconds: 2));

    if (email.isEmpty || password.isEmpty) {
      LoggerService.e("Email or password is empty");
      state = state.copyWith(isWorking: false);
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        state = state.copyWith(isSignedIn: true);
      }
    } catch (e) {
      LoggerService.e(e.toString());
    }

    state = state.copyWith(isWorking: false);
  }
}


final signInProvider =
    StateNotifierProvider<SignInProvider, SignInState>((ref) {
  return SignInProvider();
});