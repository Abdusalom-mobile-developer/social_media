import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/presentation/comments/methods/upload_comment.dart';
import 'package:social_media/providers/current_post_id.dart';
import 'package:social_media/services/shared_preferences.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

Widget commentTyperPart(
    BuildContext context, TextEditingController controller) {
  return Consumer(
    builder: (context, ref, child) => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          height: AppResponsive.height(0.13),
          width: double.infinity,
          margin: EdgeInsets.only(bottom: AppResponsive.height(0.025)),
          child: Row(
            spacing: AppResponsive.width(0.029),
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: AppResponsive.width(0.021)),
                  height: AppResponsive.height(0.063),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.black,
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppResponsive.width(0.03))),
                  child: TextField(
                    controller: controller,
                    cursorColor: AppColors.black,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: AppResponsive.width(0.039),
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Type comment...",
                      hintStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: AppResponsive.width(0.039),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  height: AppResponsive.height(0.067),
                  width: AppResponsive.width(0.139),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      String text = controller.text.trim();
                      controller.clear();
                      final user = await SharedPreferencesService.getUserInfo();
                      await uploadComment(ref.watch(currentPostId), user.uid,
                          text, user.profilePic);
                    },
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: AppColors.grey,
                      size: AppResponsive.width(0.07),
                    ),
                  ))
            ],
          ),
        ),
      ],
    ),
  );
}
