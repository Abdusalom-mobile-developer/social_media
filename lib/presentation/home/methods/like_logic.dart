import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/services/logger.dart';

class LikeLogic {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> likeAndDislikeLogic(String postId, String uid) async {
    LoggerService.d("working");
    final snapshot = await firestore.collection("posts").doc(postId).get();

    if (snapshot.exists) {
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

  Future<bool> isLiked(String postId, String uid) async {
    final snapshot = await firestore.collection("posts").doc(postId).get();

    if (snapshot.exists) {
      List<String> list = [];
      list.addAll(snapshot.data()!["likes"]);
      if (list.contains(uid)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
