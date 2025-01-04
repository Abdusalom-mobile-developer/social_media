import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/presentation/home/widgets/post_card.dart';
import 'package:social_media/services/shared_preferences.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        toolbarHeight: AppResponsive.height(0.083),
        backgroundColor: AppColors.grey,
        title: Text(
          "Dream on",
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppResponsive.widthM * 0.07,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message_rounded,
              color: AppColors.black,
              size: AppResponsive.width(0.07),
            ),
          ),
          IconButton(
            onPressed: () {
              showLogOutDialog(context);
            },
            icon: Icon(
              Icons.logout,
              color: AppColors.black,
              size: AppResponsive.width(0.07),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        onTap: (value) {
          if (value == 1) {
            context.go('/search_screen');
          } else if (value == 2) {
            context.go('/post_add');
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
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.black, width: 1.5),
              top: BorderSide(color: AppColors.black, width: 1.5),
            ),
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.black,
                ));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      data: snapshot.data!.docs[index].data(),
                    );
                  },
                );
              }
            },
          )),
    );
  }
}

void showLogOutDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog.adaptive(
      backgroundColor: AppColors.grey,
      content: Text(
        "Are you sure you want to log out?",
        style: TextStyle(
          color: AppColors.black,
          fontSize: AppResponsive.width(0.043),
          fontWeight: FontWeight.w400,
        ),
      ),
      title: Text(
        "Log out",
        style: TextStyle(
          color: AppColors.black,
          fontSize: AppResponsive.width(0.073),
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: AppResponsive.width(0.043),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            SharedPreferencesService.setSignOut();
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            context.go('/sign_in');
          },
          child: Text(
            "Log out",
            style: TextStyle(
              fontSize: AppResponsive.width(0.043),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

BottomNavigationBarItem bottomNavigationBarItem(double width, IconData? icon,
    [IoniconsData? icon2]) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon ?? icon2,
      color: AppColors.black,
      size: width * 0.073,
    ),
    activeIcon: Icon(
      icon ?? icon2,
      color: AppColors.brown,
      size: width * 0.073,
    ),
    label: "",
  );
}
