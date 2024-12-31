// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/providers/auth/auth_sign_up.dart';
import 'package:social_media/providers/image_picker.dart';
import 'package:social_media/providers/text_fields_obscure.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/presentation/auth/widgets/custom_button.dart';
import 'package:social_media/presentation/auth/widgets/custom_text.dart';
import 'package:social_media/presentation/auth/widgets/custom_text_field.dart';
import 'package:social_media/presentation/auth/widgets/custom_text_field_password.dart';

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
                                      onPressed: () async {
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
                                  file == null
                                      ? await getDefaultImageFile()
                                      : File(file!.path),
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
