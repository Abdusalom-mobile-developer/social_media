import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            onPressed: () {},
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
                    return postCardMaker(snapshot.data!.docs[index].data());
                  },
                );
              }
            },
          )),
    );
  }

  Padding postCardMaker(Map<String, dynamic> data) {
    return Padding(
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
                          image: NetworkImage(data["profilePic"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: AppResponsive.width(0.03)),
                    Text(
                      data["username"],
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
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppResponsive.width(0.03),
                ),
                child: Image(
                  image: NetworkImage(
                    data["image"],
                  ),
                  height: AppResponsive.height(0.3),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: Colors.red[900],
                        size: AppResponsive.width(0.09),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
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
                    "${data["likes"]} likes",
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
                          text: data["username"],
                          style: TextStyle(
                            fontSize: AppResponsive.width(0.041),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        TextSpan(
                          text: " ${data["description"]}",
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
                    data["timestamp"].toString(),
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
    );
  }
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
