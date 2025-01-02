import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

SizedBox centerProgressIndicator() {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitChasingDots(
          color: AppColors.black,
          size: AppResponsive.height(0.083),
        ),
        SizedBox(height: AppResponsive.height(0.09)),
      ],
    ),
  );
}
