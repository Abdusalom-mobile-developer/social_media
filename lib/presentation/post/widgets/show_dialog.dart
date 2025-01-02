import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/presentation/post/widgets/text_in_dialog.dart';
import 'package:social_media/providers/upload_post.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/responsive.dart';

void myDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.grey,
      alignment: Alignment.center,
      content: SizedBox(
        height: AppResponsive.height(0.2),
        child: Consumer(
          builder: (context, ref, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              texInDialog(context, "Choose from gallery", () async {
                XFile? image = await getImage();
                if (image != null) {
                  ref.read(uploadPostProvider.notifier).getImage(image);
                  // ignore: use_build_context_synchronously
                  context.go('/post_details');
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              }),
              texInDialog(context, "Take a photo", () {
                Navigator.pop(context);
              }),
              texInDialog(context, "Cancel", () {
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<XFile?> getImage() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

  return image;
}
