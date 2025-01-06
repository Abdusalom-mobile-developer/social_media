import 'package:cloud_firestore/cloud_firestore.dart';

class LikeLogic {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> likeAndDislikeLogic(String postId, String uid) async {
    final snapshot = await firestore.collection("posts").doc(postId).get();
    final snapshot2 = await firestore.collection("users").doc(uid).get();

    if (snapshot.exists && snapshot2.exists) {
      List<String> list = List<String>.from(snapshot.data()!["likes"]);

      if (list.contains(uid)) {
        await firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    }
  }

  static Future<void> likeLogic(String postId, String uid) async {
    final snapshot = await firestore.collection("posts").doc(postId).get();

    if (snapshot.exists) {
      List<String> list = List<String>.from(snapshot.data()!["likes"]);
      if (!list.contains(uid)) {
        await firestore.collection("posts").doc(postId).update(
          {
            "likes": FieldValue.arrayUnion([uid])
          },
        );
      }
    }
  }

  static Future<bool> isLiked(String postId, String uid) async {
    final snapshot = await firestore.collection("posts").doc(postId).get();

    if (snapshot.exists) {
      List<String> list = List<String>.from(snapshot.data()!["likes"]);
      if (list.contains(uid)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
