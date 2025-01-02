import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/presentation/home.dart';
import 'package:social_media/presentation/post/widgets/show_dialog.dart';
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
              TextButton(
                onPressed: () {
                  // To show Dialog Where Users can choose from gallery or take a photo
                  myDialog(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(0.07),
                    vertical: AppResponsive.height(0.027),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.width(0.05),
                    ),
                    border: Border.all(
                      color: AppColors.black,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload_rounded,
                        size: AppResponsive.height(0.05),
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}




