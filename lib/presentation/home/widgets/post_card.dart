import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/presentation/home/methods/format_timestamp.dart';
import 'package:social_media/presentation/home/methods/like_logic.dart';
import 'package:social_media/providers/current_post_id.dart';
import 'package:social_media/services/logger.dart';
import 'package:social_media/services/shared_preferences.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

// ignore: must_be_immutable
class PostCard extends StatefulWidget {
  Map<String, dynamic> data;
  String userUID;
  PostCard({required this.data, required this.userUID, super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onDabbleTap() {
    LoggerService.d("Method is working.");
    _controller.forward().then(
          (value) => _controller.reverse(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(0.039),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: AppResponsive.height(0.017),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: AppResponsive.height(0.065),
                        width: AppResponsive.width(0.15),
                        decoration: BoxDecoration(
                          color: AppColors.brown,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.data["profilePic"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: AppResponsive.width(0.03)),
                      Text(
                        widget.data["username"],
                        style: TextStyle(
                          fontSize: AppResponsive.width(0.041),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Transform.translate(
                    offset: Offset(AppResponsive.width(0.043), 0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        size: AppResponsive.width(0.07),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppResponsive.height(0.017),
              ),
              Stack(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onDoubleTap: () async {
                      onDabbleTap();
                      final user = await SharedPreferencesService.getUserInfo();
                      await LikeLogic.likeLogic(
                        widget.data["postID"],
                        user.uid,
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: AppResponsive.height(0.3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppResponsive.width(0.03),
                        ),
                        child: Image(
                          image: NetworkImage(
                            widget.data["image"],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: AppResponsive.height(0.3),
                    child: ScaleTransition(
                      scale: _animation,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red[900],
                        size: AppResponsive.width(0.35),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final user =
                              await SharedPreferencesService.getUserInfo();
                          await LikeLogic.likeAndDislikeLogic(
                            widget.data["postID"],
                            user.uid,
                          );
                        },
                        icon: Icon(
                          List<String>.from(widget.data["likes"])
                                  .contains(widget.userUID)
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: List<String>.from(widget.data["likes"])
                                  .contains(widget.userUID)
                              ? Colors.red[900]
                              : AppColors.black,
                          size: AppResponsive.width(0.083),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Navigating to the Comments Screen.
                          context.go("/comments_screen");
                          ref.read(currentPostId.notifier).changeCurrentPostId(
                                widget.data["postID"],
                              );
                        },
                        icon: Icon(
                          Icons.message_rounded,
                          color: AppColors.black,
                          size: AppResponsive.width(0.075),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.paperplane_fill,
                          color: AppColors.black,
                          size: AppResponsive.width(0.075),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_outline_rounded,
                      color: AppColors.black,
                      size: AppResponsive.width(0.075),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.width(0.02),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.data["likes"].length} likes",
                      style: TextStyle(
                        fontSize: AppResponsive.width(0.041),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: AppResponsive.height(0.01),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.data["username"],
                            style: TextStyle(
                              fontSize: AppResponsive.width(0.041),
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: " ${widget.data["description"]}",
                            style: TextStyle(
                              fontSize: AppResponsive.width(0.041),
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppResponsive.height(0.01),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "View all 999 comments",
                        style: TextStyle(
                          fontSize: AppResponsive.width(0.043),
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Text(
                      formatTimestamp(widget.data["timestamp"]),
                      style: TextStyle(
                        fontSize: AppResponsive.width(0.041),
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<int> numberOfCommentsFinder(WidgetRef ref) async {
  final data = await FirebaseFirestore.instance
      .collection("posts")
      .doc()
      .collection("comments")
      .get();
  return data.size;
}
