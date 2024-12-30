import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/services/logger.dart';

class SignUpState {
  final bool isSignedUp;
  final bool isWorking;

  SignUpState({required this.isSignedUp, required this.isWorking});

  SignUpState copyWith({bool? isSignedUp, bool? isWorking}) {
    return SignUpState(
      isSignedUp: isSignedUp ?? this.isSignedUp,
      isWorking: isWorking ?? this.isWorking,
    );
  }
}

class SignUpProvider extends StateNotifier<SignUpState> {
  SignUpProvider() : super(SignUpState(isSignedUp: false, isWorking: false));

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get user => _auth.currentUser?.uid;

  Future<void> signUp(String username, String email, String password,
      String confirmPassword) async {
    state = state.copyWith(isWorking: true);

    await Future.delayed(const Duration(seconds: 2));

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        confirmPassword != password ||
        password != confirmPassword ||
        !email.contains("@") ||
        password.length < 6 ||
        username.length < 6 ||
        email.length < 6) {
      LoggerService.e("Inputs are invalid.");
      state = state.copyWith(isWorking: false);
      return;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await _firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            "username": username,
            "email": email,
            "password": password,
          },
        );
        state = state.copyWith(isSignedUp: true);
      }
    } catch (e) {
      LoggerService.e(e.toString());
    }

    state = state.copyWith(isWorking: false);
  }
}

final signUpProvider =
    StateNotifierProvider<SignUpProvider, SignUpState>((ref) {
  return SignUpProvider();
});
