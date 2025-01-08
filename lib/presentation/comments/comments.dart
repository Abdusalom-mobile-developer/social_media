import 'package:flutter/material.dart';
import 'package:social_media/presentation/comments/widgets/comment_typer_part.dart';
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
              commentTyperPart(context, controller),
            ],
          ),
        ),
      ),
    );
  }
}
