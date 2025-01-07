import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/services/shared_preferences.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

void showLogOutDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog.adaptive(
      backgroundColor: AppColors.grey,
      content: Text(
        "Are you sure you want to log out?",
        style: TextStyle(
          color: AppColors.black,
          fontSize: AppResponsive.width(0.043),
          fontWeight: FontWeight.w400,
        ),
      ),
      title: Text(
        "Log out",
        style: TextStyle(
          color: AppColors.black,
          fontSize: AppResponsive.width(0.073),
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: AppResponsive.width(0.043),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            SharedPreferencesService.setSignOut();
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            context.go('/sign_in');
          },
          child: Text(
            "Log out",
            style: TextStyle(
              fontSize: AppResponsive.width(0.043),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

