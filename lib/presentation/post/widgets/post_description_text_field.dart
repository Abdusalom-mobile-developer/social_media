import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

Container postDescription(TextEditingController controller) {
    return Container(
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
        controller: controller,
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
    );
  }