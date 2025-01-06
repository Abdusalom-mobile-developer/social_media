import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/presentation/post/widgets/post_description_text_field.dart';
import 'package:social_media/presentation/post/widgets/progress_indicator.dart';
import 'package:social_media/providers/upload_post.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  bool isPosting = false;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Scaffold(
          backgroundColor: AppColors.grey,
          appBar: AppBar(
            backgroundColor: AppColors.grey,
            // AppBar Back Button
            leading: IconButton(
              onPressed: () {
                context.go('/post_add');
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                size: AppResponsive.widthM * 0.11,
              ),
            ),
            actions: [
              // AppBar Post Text Part
              TextButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isPosting = !isPosting;
                  });
                  bool result =
                      await ref.read(uploadPostProvider.notifier).uploadPost(
                            ref.watch(uploadPostProvider)["imageURL"],
                            _descriptionController.text.trim(),
                          );
                  if (result) {
                    // ignore: use_build_context_synchronously
                    context.go('/home_screen');
                  } else {
                    setState(
                      () {
                        isPosting = !isPosting;
                      },
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.black,
                        content: Text(
                          "Failed to post",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: AppResponsive.width(0.05),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppResponsive.width(0.05),
                  ),
                ),
              ),
              SizedBox(width: AppResponsive.width(0.02)),
            ],
          ),
          body: ref.watch(uploadPostProvider)["imageURL"] == null
              ? centerProgressIndicator()
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        // Body Liner Progress Indicator
                        isPosting
                            ? LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(
                                  AppResponsive.height(0.1),
                                ),
                                minHeight: AppResponsive.height(0.0041),
                                backgroundColor: AppColors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.black),
                              )
                            : SizedBox(
                                height: AppResponsive.height(0.0041),
                              ),
                        // Body Post Image Part
                        Container(
                          width: double.infinity,
                          height: AppResponsive.height(0.3),
                          margin: EdgeInsets.symmetric(
                            horizontal: AppResponsive.width(0.05),
                            vertical: AppResponsive.height(0.023),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppResponsive.height(0.02),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                ref.watch(uploadPostProvider)["imageURL"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Body Description Part
                        postDescription(_descriptionController),
                      ],
                    ),
                  ),
                )),
    );
  }
}
