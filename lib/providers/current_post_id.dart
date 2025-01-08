import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentPostId extends StateNotifier<String> {
  CurrentPostId() : super("");

  void changeCurrentPostId(String postId) {
    state = postId;
  }
}

final currentPostId = StateNotifierProvider<CurrentPostId, String>(
  (ref) => CurrentPostId(),
);
