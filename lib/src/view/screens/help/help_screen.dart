import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/home_controller.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        appBar: CustomAppBar(title: 'help'.tr),
        backgroundColor: MyColor.getBackgroundColor(),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              // padding: const EdgeInsets.all(MySizes.marginSizeDefault),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(MyImage.contactSearch, fit: BoxFit.scaleDown, height: 250, width: 250),
                ),
                Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('contact_info'.tr, style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor()),),
                    const SizedBox(width: MySizes.marginSizeExtraSmall),
                    SvgPicture.asset(MyImage.help, height: 24, width: 24, color: MyColor.getPrimaryColor(),),
                  ],
                ),
                InkWell(
                  onTap: () => launchEmail('molla.ux@gmail.com'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(MyImage.mail, height: 24, width: 24,),
                        const SizedBox(width: MySizes.marginSizeExtraSmall),
                        Text('molla.ux@gmail.com', style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor()),),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  launchEmail(String email) async {
    await canLaunchUrl(Uri.parse('mailto:$email?subject=&body='))
        ? await launchUrl(Uri.parse('mailto:$email?subject=&body='))
        : throw 'Could not launch ${'mailto:$email?subject=&body='}';
  }
}
