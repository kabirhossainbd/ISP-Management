import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/theme_controller.dart';
import 'package:isp_management/src/config/themes/custom_theme.dart';
import 'package:isp_management/src/view/base/custom_toast.dart';
import 'package:isp_management/src/view/screens/auth/auth.dart';
import 'package:isp_management/src/view/screens/help/help_screen.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

import '../../../../controller/localization_controller.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({super.key});

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleOffset = Offset(size.width - 20, size.height - 20);
    return GetBuilder<ThemeController>(
      builder: (theme) => DarkTransition(
        childBuilder: (context, value) => MenuScreen(
          onTap: () {
            theme.toggleTheme();
          },
        ),
        offset: circleOffset,
        isDark: theme.darkTheme,
      ),
    );
  }
}


class MenuScreen extends StatefulWidget {
  final VoidCallback onTap;
  const MenuScreen({super.key, required this.onTap});


  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  // ScreenshotController screenshotController = ScreenshotController();
  // void shareSocialNetwork() async {
  //   String imagePath = await screenshotController.capture().then((image) async {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final file = await File('${directory.path}/temp.png').create();
  //     await file.writeAsBytes(image!);
  //     return file.path;
  //   });
  //
  //   ShareSocialNetwork.show(
  //     context: Get.context!,
  //     backgroundColor: Colors.white,
  //     pillColor: Colors.black12,
  //     transitionDuration: const Duration(milliseconds: 300),
  //     screenshotController: screenshotController,
  //     copyToClipboard: "https://github.com/weeidl/share_social...",
  //     telegram: Telegram(
  //       content: "Share with friend and get more \n https://github.com/weeidl",
  //     ),
  //     instagram: Instagram(
  //       backgroundBottomColor: "#FF7391",
  //       backgroundTopColor: "#591E78",
  //       attributionURL: "https://deep-link-url",
  //       imagePath: imagePath,
  //     ),
  //     facebook: Facebook(
  //       backgroundTopColor: "#ffffff",
  //       attributionURL: "https://github.com/weeidl",
  //       backgroundBottomColor: "#000000",
  //       imagePath: imagePath,
  //       appId: "xxxxxxxxxxxxx",
  //     ),
  //     more: More(
  //       message: 'Share with friend and get more \n https://github.com/weeidl',
  //     ),
  //     twitter: Twitter(
  //       captionText: 'Share with friend and get more',
  //       hashtags: ["hello", "world", "weeild", "artur"],
  //       url: 'https://github.com/weeidl',
  //       trailingText: " \nweeidl",
  //     ),
  //     whatsapp: Whatsapp(
  //       content: 'Share with friend and get more \n https://github.com/weeidl',
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (local) => GetBuilder<ThemeController>(
        builder: (theme) => Scaffold(
          appBar: AppBar(
            title: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Menu'.tr, style: robotoLight.copyWith(fontSize: 22,
                  color: MyColor.colorWhite,
                )),
              ],
            ),
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              icon: const Icon(Icons.arrow_back, color: MyColor.colorWhite, size: 20,),
              onPressed: () => Get.back(canPop: true),
            ),
            elevation: 1,
            centerTitle: false,
            backgroundColor: MyColor.colorPrimary,
            shadowColor: MyColor.colorBlack.withOpacity(0.12),
            bottomOpacity: 0.3,
            automaticallyImplyLeading: false,
            titleSpacing: 10,
          ),
          body: SafeArea(
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(MySizes.marginSizeDefault),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('https://i.pinimg.com/736x/ef/96/be/ef96be5425be0fa5d1c817b36bb2020a.jpg'),
                      ),
                      const SizedBox(width: MySizes.paddingSizeMiniSmall),
                      Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Mr John', style: robotoLight.copyWith(fontSize: MySizes.fontSizeOverLarge)),
                          Text('app developer', style: robotoRegular.copyWith(fontSize: MySizes.fontSizeDefault)),
                        ],
                      )
                    ],
                  ),
                ),

                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           SvgPicture.asset(MyImage.language, height: 24, width: 24, color: MyColor.colorPrimary),
                //           const SizedBox(width: MySizes.marginSizeMiniSmall),
                //           Text('change_language'.tr, style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge),),
                //           const Spacer(),
                //           InkWell(
                //             onTap: () => local.toggleLanguage(),
                //             child: Container(
                //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //               decoration: BoxDecoration(
                //                 // color: MyColor.getBackgroundColor(),
                //                   borderRadius: BorderRadius.circular(16),
                //                   border: Border.all(color: MyColor.getPrimaryColor(), width: 1)
                //               ),
                //               child: Text(
                //                 local.locale.languageCode == 'en'
                //                     ? 'English'.tr
                //                     :'Arabic'.tr,
                //                 style: robotoRegular.copyWith(fontSize: MySizes.fontSizeSmall),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                //       child: Divider(height: 1,),
                //     ),
                //   ],
                // ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(MyImage.darkTheme, height: 24, width: 24, color: MyColor.colorPrimary,),
                          const SizedBox(width: MySizes.marginSizeMiniSmall),
                          Text('dark_mode'.tr, style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge),),
                          const Spacer(),

                          InkWell(
                            onTap: ()=> theme.toggleTheme(),
                            child: Container(
                              width: 34,
                              height: 20,
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: theme.darkTheme ? MyColor.colorPrimary : Colors.grey.shade300,
                              ),
                              child: Row(
                                children:  [
                                  if(theme.darkTheme)...[
                                    const Expanded(
                                        child:
                                        SizedBox()),
                                    const Padding(padding: EdgeInsets.all(1.0), child: CircleAvatar(radius: 5, backgroundColor: Colors.white,)),
                                  ]else...[
                                    const Padding(padding: EdgeInsets.all(1.0), child: CircleAvatar(radius: 4,backgroundColor: Colors.black)),
                                    const Expanded(child: SizedBox()),
                                  ]

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Divider(height: 1,),
                    ),
                  ],
                ),


                _rowItem(MyImage.help, 'help'.tr, onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => const HelpScreen()));
                }),
                _rowItem(MyImage.rate, 'rate_us'.tr, onTap: (){
                  showSnackBar('Coming soon...');
                }),
                _rowItem(MyImage.share, 'share_with_friends'.tr, onTap: (){
                  showSnackBar('Coming soon...');
                  // shareSocialNetwork();
                }),
                _rowItem(MyImage.logout, 'log_out'.tr, onTap: _customLogout),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _rowItem(String image, String text, {VoidCallback? onTap}){
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(image, height: 24, width: 24, color: MyColor.colorPrimary,),
                const SizedBox(width: MySizes.marginSizeMiniSmall),
                Text(text, style: robotoLight.copyWith( fontSize: MySizes.fontSizeLarge),),
                const Expanded(child: SizedBox()),
                // SvgPicture.asset(MyImage.rightArrow, color: Theme.of(context).hintColor, height: 24, width: 24,),
                const Icon(Icons.arrow_forward_ios_outlined, size: 20,),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Divider(height: 1,),
          ),
        ],
      ),
    );
  }



  void _customLogout() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  alignment: Alignment.center,
                  backgroundColor: MyColor.getBottomSheetColor(),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () => Get.back(),
                                child: Text('cancel'.tr,
                                  style: robotoRegular.copyWith(
                                      color: MyColor.colorGrey,
                                      fontSize:
                                      MySizes.fontSizeDefault),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )),
                            const SizedBox(width: 50,),
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: (){
                                  Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_) => const SignInScreen()), (route) => false);
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF54336),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "log_out".tr,
                                    style: robotoRegular.copyWith(
                                        color: MyColor.colorWhite,
                                        fontSize:
                                        MySizes.fontSizeDefault),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                            )
                          ]),
                    )
                  ],
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text('log_out'.tr, style: robotoLight.copyWith(
                      color: MyColor.getTextColor(),
                      fontSize: 28),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                  content:  Text( 'are_you_sure_want'.tr,
                    style: robotoLight.copyWith(
                        color: MyColor.getTextColor(),
                        fontSize:
                        MySizes.fontSizeLarge),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }
}



