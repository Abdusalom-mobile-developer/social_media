import 'package:flutter/material.dart';
import 'package:social_media/presentation/post/widgets/show_dialog.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

TextButton uploadButton(BuildContext context) {
    return TextButton(
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
            );
  }
