import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/presentation/comments/widgets/comment_typer_part.dart';
import 'package:social_media/presentation/home/methods/format_timestamp.dart';
import 'package:social_media/providers/current_post_id.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

// ignore: must_be_immutable
class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Scaffold(
        backgroundColor: AppColors.grey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.grey,
          toolbarHeight: AppResponsive.height(0.1),
          leading: GestureDetector(
            onTap: () {
              context.go("/home_screen");
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
              size: AppResponsive.width(0.075),
            ),
          ),
          title: Text(
            "Comments",
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppResponsive.width(0.061),
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.width(0.037),
            ),
            width: double.infinity,
            child: Stack(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .doc(ref.watch(currentPostId))
                      .collection("comments")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => commentMaker(
                          snapshot.data!.docs[index].data(),
                        ),
                      );
                    }
                  },
                ),
                commentTyperPart(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container commentMaker(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: AppResponsive.height(0.023)),
      padding: EdgeInsets.symmetric(vertical: AppResponsive.height(0.01)),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppResponsive.height(0.055),
            width: AppResponsive.width(0.13),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(data["userProfilePic"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: AppResponsive.width(0.039),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: data["username"] + " ",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: AppResponsive.width(0.047),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "${data["commentText"]}\n",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: AppResponsive.width(0.043),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.19,
                    ),
                  ),
                  TextSpan(
                    text: formatTimestamp(data["dateCommented"]),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: AppResponsive.width(0.045),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
