import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onPressed;
  const CustomAppBar({super.key, required this.title, this.onPressed});

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: MyColor.getPrimaryColor(),
        elevation: 0,
        leading: IconButton(
          icon:  const Icon(Icons.arrow_back, color: MyColor.colorWhite),
          onPressed: ()=> Get.back(),
        ),
        title: Text(title ?? '', style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeLarge)),
      ),
    );
  }
}

