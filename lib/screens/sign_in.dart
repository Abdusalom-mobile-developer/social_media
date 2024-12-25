// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/screens/sign_up.dart';
import 'package:social_media/state_management/sign_in.dart';
import 'package:social_media/state_management/text_fields_obscure.dart';
import 'package:social_media/utils/colors.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Height and width of the screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (context, ref, child) => Scaffold(
        backgroundColor: AppColors.grey,
        body: ref.watch(signInProvider)
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.translate(
                            offset: Offset(
                              0,
                              height * 0.039,
                            ),
                            child: Lottie.asset(
                              "assets/animations/waving.json",
                              height: height * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                          customTextField(
                            height,
                            width,
                            emailController,
                            Icons.email,
                            "Email address",
                          ),
                          Consumer(
                            builder: (context, ref, child) =>
                                customTextFieldPassword(
                              height,
                              width,
                              passwordController,
                              Icons.lock,
                              "Password",
                              ref.watch(textFieldsObscureSignInProvider),
                              () {
                                ref
                                    .read(textFieldsObscureSignInProvider
                                        .notifier)
                                    .changeTheValue();
                              },
                            ),
                          ),
                          customButton(height, width, "Sign In", () {
                            ref.read(signInProvider.notifier).signIn();
                          }),
                          SizedBox(
                            height: height * 0.026,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customText(
                                "Don't have an account? ",
                                AppColors.black,
                                height * 0.023,
                                FontWeight.w400,
                                '',
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.go('/sign_up');
                                },
                                child: customText(
                                  "Sign up",
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
