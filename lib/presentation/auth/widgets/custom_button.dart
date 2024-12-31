import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';

Widget customButton(double height, width, String text, VoidCallback function) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: height * 0.01),
    margin: EdgeInsets.only(top: height * 0.026),
    height: height * 0.071,
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.black,
      borderRadius: BorderRadius.circular(height * 0.01),
      border: Border.all(color: AppColors.black, width: height * 0.002),
    ),
    child: TextButton(
      style: ButtonStyle(
        minimumSize:
            WidgetStatePropertyAll(Size(double.infinity, double.infinity)),
      ),
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(color: AppColors.grey, fontSize: height * 0.023),
      ),
    ),
  );
}