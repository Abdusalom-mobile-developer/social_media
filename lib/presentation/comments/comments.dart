import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

// ignore: must_be_immutable
class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        toolbarHeight: AppResponsive.height(0.1),
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.black,
          size: AppResponsive.width(0.075),
        ),
        title: Text(
          "Comments",
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppResponsive.width(0.061),
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.width(0.037),
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: AppResponsive.height(0.13),
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(bottom: AppResponsive.height(0.025)),
                    child: Row(
                      spacing: AppResponsive.width(0.029),
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: AppResponsive.width(0.021)),
                            height: AppResponsive.height(0.063),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    AppResponsive.width(0.03))),
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
                              onPressed: () {
                                controller.clear();
                                FocusScope.of(context).unfocus();
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
            ],
          ),
        ),
      ),
    );
  }
}
