import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media/utils/colors.dart';

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
