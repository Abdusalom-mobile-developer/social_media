import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UploadPost extends StateNotifier<Map<String, dynamic>> {
  UploadPost() : super({});

  Future<void> getImage(XFile file) async {
    final storage = FirebaseStorage.instance.ref();

    Reference reference =
        storage.child("posts/${DateTime.now().microsecondsSinceEpoch}.jpg");

    await reference.putFile(File(file.path));

     String imageUrl = await reference.getDownloadURL();

    state = {
      "imageURL": imageUrl,
    };
  }
}

final uploadPostProvider =
    StateNotifierProvider<UploadPost, Map<String, dynamic>>(
  (ref) {
    return UploadPost();
  },
);
