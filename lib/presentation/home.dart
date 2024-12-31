import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.grey,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          items: [
            bottomNavigationBarItem(AppResponsive.widthM, Icons.home),
            bottomNavigationBarItem(
                AppResponsive.widthM, null, Ionicons.search_sharp),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_rounded,
                color: AppColors.black,
                size: AppResponsive.widthM * 0.13,
              ),
              activeIcon: Icon(
                Icons.add_circle_rounded,
                color: AppColors.brown,
                size: AppResponsive.widthM * 0.13,
              ),
              label: "",
            ),
            bottomNavigationBarItem(
                AppResponsive.widthM, Icons.favorite_rounded),
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
            bottom: BorderSide(
              color: AppColors.black,
              width: AppResponsive.heightM * 0.0029,
            ),
          )),
        ));
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
