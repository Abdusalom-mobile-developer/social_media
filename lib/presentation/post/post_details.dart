import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  bool isPosting = false;

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
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isPosting = !isPosting;
                });
                Timer(Duration(seconds: 5), () {
                  setState(() {
                    isPosting = !isPosting;
                  });
                });
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
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                isPosting
                    ? LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(
                          AppResponsive.height(0.1),
                        ),
                        minHeight: AppResponsive.height(0.0041),
                        backgroundColor: AppColors.grey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.black),
                      )
                    : SizedBox(
                        height: AppResponsive.height(0.0041),
                      ),
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
                          "https://i.pinimg.com/736x/43/12/0b/43120bdf6d03fbc702f853718eb61b47.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: AppResponsive.height(0.059),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(0.05),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(0.019),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.black, width: 1.5),
                    ),
                  ),
                  child: TextField(
                    cursorColor: AppColors.black,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                      color: AppColors.black,
                      fontSize: AppResponsive.width(0.043),
                    ),
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: AppResponsive.width(0.043),
                      ),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
