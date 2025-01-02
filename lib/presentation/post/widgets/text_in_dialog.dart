import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

TextButton texInDialog(
    BuildContext context, String text, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.black,
        fontSize: AppResponsive.width(0.039),
      ),
    ),
  );
}