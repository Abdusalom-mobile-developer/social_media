import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import 'package:social_media/presentation/home/widgets/bottom_nav_bar.dart';
import 'package:social_media/presentation/post/widgets/upload_button.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class PostAddScreen extends StatelessWidget {
  const PostAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.grey,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 2,
        onTap: (value) {
          if (value == 0) {
            context.go('/home_screen');
          } else if (value == 1) {
            context.go('/search_screen');
          } else if (value == 3) {
            context.go('/favorite_screen');
          } else if (value == 4) {
            context.go('/profile_screen');
          }
        },
        items: [
          bottomNavigationBarItem(AppResponsive.widthM, Icons.home),
          bottomNavigationBarItem(
              AppResponsive.widthM, null, Ionicons.search_sharp),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_rounded,
              color: AppColors.black,
              size: AppResponsive.widthM * 0.11,
            ),
            activeIcon: Icon(
              Icons.add_circle_rounded,
              color: AppColors.brown,
              size: AppResponsive.widthM * 0.11,
            ),
            label: "",
          ),
          bottomNavigationBarItem(AppResponsive.widthM, Icons.favorite_rounded),
          bottomNavigationBarItem(
            AppResponsive.widthM,
            Icons.person_rounded,
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.black, width: 1.5),
            ),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              uploadButton(context),
            ],
          )),
    );
  }
}
