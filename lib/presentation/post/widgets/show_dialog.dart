import 'package:flutter/material.dart';
import 'package:social_media/presentation/post/text_in_dialog.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

void myDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.grey,
      alignment: Alignment.center,
      content: SizedBox(
        height: AppResponsive.height(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            texInDialog(context, "Choose from gallery", () {
              Navigator.pop(context);
            }),
            texInDialog(context, "Take a photo", () {
              Navigator.pop(context);
            }),
            texInDialog(context, "Cancel", () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    ),
  );
}