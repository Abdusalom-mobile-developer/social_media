import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/presentation/home.dart';
import 'package:social_media/services/shared_preferences.dart';
import 'package:social_media/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 2300),
      () {
        checkSignIn(context);
      },
    );
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/world.json",
              height: 300,
              fit: BoxFit.contain,
            ),
            Transform.translate(
              offset: Offset(0, -(height * 0.039)),
              child: Text(
                "Dream On",
                style: TextStyle(
                  fontSize: width * 0.083,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}

void checkSignIn(BuildContext context) async {
  bool isSignedIn = await SharedPreferencesService.checkSignIn();
  if (isSignedIn) {
    Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
  }
}
