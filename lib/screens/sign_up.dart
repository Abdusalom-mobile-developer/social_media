// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/services/auth/auth_sign_up.dart';
import 'package:social_media/services/image_picker.dart';
import 'package:social_media/services/text_fields_obscure.dart';
import 'package:social_media/utils/colors.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    // Height and width of the screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (context, ref, child) => Scaffold(
        backgroundColor: AppColors.grey,
        body: ref.watch(signUpProvider).isWorking
            ? Center(
                child: SpinKitChasingDots(
                  color: AppColors.black,
                  size: height * 0.083,
                ),
              )
            : Padding(
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
                            width: height * 0.2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ref.watch(imageProvider) == null
                                    ? NetworkImage("https://i.pravatar.cc/300")
                                    : FileImage(
                                        File(ref.watch(imageProvider)!),
                                      ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: height * 0.051,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.black,
                                    ),
                                    child: IconButton(
                                      onPressed: () async{
                                         file = await ref
                                            .read(imageProvider.notifier)
                                            .getImage();
                                      },
                                      icon: Icon(
                                        Icons.add_rounded,
                                        color: AppColors.grey,
                                        size: height * 0.035,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                          customTextFieldPassword(
                            height,
                            width,
                            passwordController,
                            Icons.lock,
                            "Password",
                            ref.watch(textFieldsObscureSignUpProvider),
                            () {
                              ref
                                  .read(
                                      textFieldsObscureSignUpProvider.notifier)
                                  .changeTheValue();
                            },
                          ),
                          customTextFieldPassword(
                            height,
                            width,
                            passwordConfirmController,
                            Icons.lock,
                            "Confirm Password",
                            ref.watch(textFieldsObscureSignUp2Provider),
                            () {
                              ref
                                  .read(
                                      textFieldsObscureSignUp2Provider.notifier)
                                  .changeTheValue();
                            },
                          ),
                          customButton(height, width, "Sign Up", () async {
                            await ref.read(signUpProvider.notifier).signUp(
                                  usernameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  passwordConfirmController.text.trim(),
                                 file == null ? await getDefaultImageFile() : File(file!.path),
                                );
                            if (ref.watch(signUpProvider).isSignedUp) {
                              // ignore: use_build_context_synchronously
                              context.go('/home_screen');
                            }
                            emailController.clear();
                            passwordController.clear();
                            passwordConfirmController.clear();
                            usernameController.clear();
                          }),
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

Future<File> getDefaultImageFile() async {
  // Load asset as byte data
  final byteData = await rootBundle.load('assets/images/eminem.jpg');

  // Write to a temporary file
  final tempDir = Directory.systemTemp;
  final tempFile = File('${tempDir.path}/eminem.jpg');
  await tempFile.writeAsBytes(byteData.buffer.asUint8List());

  return tempFile;
}