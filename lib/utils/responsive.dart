import 'package:flutter/material.dart';

class AppResponsive {
  static double heightM = 0;
  static double widthM = 0;

  static void init(BuildContext context) {
    final media = MediaQuery.of(context).size;
    heightM = media.height;
    widthM = media.width;
  }

  static double height(double percentage) {
    return heightM * percentage;
  }

  static double width(double percentage) {
    return widthM * percentage;
  }
}
