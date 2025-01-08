import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadComment(String postId, String userUID, String comment, String userProfilePic) async {
  final database = FirebaseFirestore.instance;

  await database.collection("posts").doc(postId).collection("comments").doc(DateTime.now().microsecondsSinceEpoch.toString()).set(
    {
      "userUID": userUID,
      "commentText": comment,
      "userProfilePic": userProfilePic,
      "dateCommented": Timestamp.now(),
    },
  );
}
