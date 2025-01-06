import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/services/logger.dart';
import 'package:social_media/services/shared_preferences.dart';

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
  final _storage = FirebaseStorage.instance.ref();

  String? get user => _auth.currentUser?.uid;

  Future<void> signUp(
    String username,
    String email,
    String password,
    String confirmPassword,
    File file,
  ) async {
    state = state.copyWith(isWorking: true);

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
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Reference reference = _storage
            .child("images/${DateTime.now().microsecondsSinceEpoch}.jpg");

        await reference.putFile(file);

        final downloadIUrl = await reference.getDownloadURL();

        await _firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            "uid": userCredential.user!.uid,
            "username": username,
            "email": email,
            "password": password,
            "profile_image": downloadIUrl,
            "liked_posts": []
          },
        );

       await SharedPreferencesService.storeUserInfo(
          userCredential.user!.uid,
          username,
          email,
          password,
          downloadIUrl,
        );

        state = state.copyWith(isSignedUp: true);
        await SharedPreferencesService.setSignIn();
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
