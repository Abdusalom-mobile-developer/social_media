import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: IconButton(
          onPressed: () {
            context.go('/post_add');
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: AppResponsive.widthM * 0.11,
          ),
        ),
      ),
      body: Center(
        child: Text("Post Details"),
      ),
    );
  }
}
