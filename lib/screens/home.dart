import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Center(
        child: Lottie.asset(
          "assets/animations/world.json",
          height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
