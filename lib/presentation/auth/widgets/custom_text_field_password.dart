import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/utils/colors.dart';

Widget customTextFieldPassword(
  double height,
  width,
  TextEditingController controller,
  IconData icon,
  String text,
  bool isObscure,
  VoidCallback function,
) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: height * 0.01),
    margin: EdgeInsets.only(top: height * 0.026),
    height: height * 0.071,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.01),
        border: Border.all(color: AppColors.black, width: height * 0.002)),
    child: Row(
      children: [
        Icon(
          icon,
          size: height * 0.033,
          color: AppColors.black,
        ),
        SizedBox(
          width: width * 0.019,
        ),
        Expanded(
          child: TextField(
            obscureText: isObscure,
            controller: controller,
            cursorColor: AppColors.black,
            style: TextStyle(
              decoration: TextDecoration.none,
              decorationColor: Colors.transparent,
              decorationThickness: 0,
              color: AppColors.black,
              fontSize: height * 0.023,
            ),
            decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(
                color: AppColors.black,
                fontSize: height * 0.023,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.019,
        ),
        Consumer(
          builder: (context, ref, child) => GestureDetector(
            onTap: function,
            child: Icon(
              size: height * 0.033,
              isObscure ? Icons.visibility : Icons.visibility_off,
              color: AppColors.black,
            ),
          ),
        ),
        SizedBox(
          width: width * 0.029,
        ),
      ],
    ),
  );
}