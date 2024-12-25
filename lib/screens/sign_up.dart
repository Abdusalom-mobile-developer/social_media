// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/utils/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Height and width of the screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    bool isObscure = true;
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Container(
                    height: height * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("https://i.pravatar.cc/300"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  customTextField(
                    height,
                    width,
                    usernameController,
                    Icons.person,
                    "Username",
                  ),
                  customTextField(
                    height,
                    width,
                    emailController,
                    Icons.email,
                    "Email address",
                  ),
                  customTextField(
                    height,
                    width,
                    passwordController,
                    Icons.lock,
                    "Password",
                  ),
                  customTextField(
                    height,
                    width,
                    passwordConfirmController,
                    Icons.lock,
                    "Confirm Password",
                  ),
                  customButton(height, width, "Sign Up"),
                  SizedBox(
                    height: height * 0.026,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                        "Already have an account? ",
                        AppColors.black,
                        height * 0.023,
                        FontWeight.w400,
                        '',
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/sign_in');
                        },
                        child: customText(
                          "Sign in",
                          AppColors.black,
                          height * 0.023,
                          FontWeight.w600,
                          '',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(double height, width, TextEditingController controller,
      IconData icon, String text) {
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
                  )),
            ),
          )
        ],
      ),
    );
  }
}

Widget customText(String content, Color color, double fontSize,
    FontWeight fontWeight, String fontFamily) {
  return Text(
    content,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    ),
  );
}

Widget customButton(double height, width, String text) {
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
    child: Text(
      text,
      style: TextStyle(color: AppColors.grey, fontSize: height * 0.023),
    ),
  );
}

Widget customTextField(double height, width, TextEditingController controller,
    IconData icon, String text) {
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
                )),
          ),
        )
      ],
    ),
  );
}

Widget customTextFieldPassword(
    double height,
    width,
    TextEditingController controller,
    IconData icon,
    String text,
    bool isObscure) {
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
                suffix:
                    Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                hintText: text,
                hintStyle: TextStyle(
                  color: AppColors.black,
                  fontSize: height * 0.023,
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                )),
          ),
        )
      ],
    ),
  );
}
