import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

Container userSearchCard(Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      height: AppResponsive.height(0.09),
      margin: EdgeInsets.only(
        bottom: AppResponsive.height(0.023),
      ),
      child: Row(
        children: [
          Container(
            height: AppResponsive.height(0.09),
            width: AppResponsive.width(0.17),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
              image: DecorationImage(
                image: NetworkImage(data["profile_image"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: AppResponsive.width(0.037),
          ),
          Text(
            data["username"],
            style: TextStyle(
              color: AppColors.black,
              fontSize: AppResponsive.width(0.045),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }