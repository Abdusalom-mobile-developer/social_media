import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        toolbarHeight: AppResponsive.height(0.1),
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.black,
          size: AppResponsive.width(0.075),
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
      bottomNavigationBar: Container(
        height: AppResponsive.height(0.13),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(0.025),
        ),
        decoration: BoxDecoration(
          color: AppColors.black,
        ),
        child: Row(
          children: [
            Container(
              height: AppResponsive.height(0.067),
              width: AppResponsive.width(0.15),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/736x/a7/af/1f/a7af1fd8c5f21f1fc5873ab49f95190e.jpg"),
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(0.03),
        ),
        width: double.infinity,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
