import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/services/logger.dart';
import 'package:social_media/services/shared_preferences.dart';

class UploadPost extends StateNotifier<Map<String, dynamic>> {
  UploadPost() : super({});

  Future<void> getImage(XFile file) async {
    state = {
      "imageURL": null,
    };

    final storage = FirebaseStorage.instance.ref();

    Reference reference =
        storage.child("posts/${DateTime.now().microsecondsSinceEpoch}.jpg");

    await reference.putFile(File(file.path));

    String imageUrl = await reference.getDownloadURL();

    state = {
      "imageURL": imageUrl,
    };
  }

  Future<bool> uploadPost(String image, String description) async {
    try {
      final firestore = FirebaseFirestore.instance;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final user = await SharedPreferencesService.getUserInfo();

      final String postId = DateTime.now().microsecondsSinceEpoch.toString();

      await firestore.collection("posts").doc(postId).set({
        "uid": uid,
        "username": user.username,
        "image": image,
        "description": description,
        "likes": [],
        "timestamp": Timestamp.now(),
        "profilePic": user.profilePic,
        "postID": postId,
      });
    } catch (e) {
      LoggerService.e(e.toString());
      return false;
    }

    return true;
  }
}

final uploadPostProvider =
    StateNotifierProvider<UploadPost, Map<String, dynamic>>(
  (ref) {
    return UploadPost();
  },
);
