import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:isp_management/src/view/screens/chat/chat_screen.dart';
import 'package:isp_management/src/view/screens/home/home_screen.dart';
import 'package:isp_management/src/view/screens/menu/menu.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_style.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);


    _screens = [
      const HomeScreen(),
      const ChatScreen(),
       Container(),
      const DarkMode(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            // showCustomToast(translatedText('again_to_exit', context)!, isError: false);
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SizedBox(
          height: 56,
          child: Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  boxShadow: [
                    BoxShadow(
                        color: MyColor.colorWhite.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0,4)
                    )
                  ]
              ),
              child: Row( crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(image: _pageIndex == 0 ? MyImage.homeColor :  MyImage.homeNoColor,  title: 'home'.tr, isSelected: _pageIndex == 0, color: _pageIndex == 0 ? MyColor.colorPrimary : MyColor.colorGrey,  onTap: () {
                    _setPage(0);
                  },),
                  BottomNavItem(image: _pageIndex == 1 ?MyImage.chatColor :  MyImage.chatNoColor,  title: 'chat'.tr, isSelected: _pageIndex == 1, color: _pageIndex == 1 ? MyColor.colorPrimary : MyColor.colorGrey,  onTap: () {
                    _setPage(1);

                  },),

                  // BottomNavItem(image: _pageIndex == 2 ? MyImage.micColor :  MyImage.micNoColor,  title: 'Voice', isSelected: _pageIndex == 2, color: _pageIndex == 2 ? MyColor.colorPrimary : MyColor.colorGrey, onTap: () {
                  //     _setPage(2);
                  //   },
                  // ),


                  BottomNavItem(image: _pageIndex == 3 ? MyImage.moreColor :  MyImage.moreNoColor,  title: 'menu'.tr, isSelected: _pageIndex == 3, color: _pageIndex == 3 ? MyColor.colorPrimary : MyColor.colorGrey, onTap: () {
                    _setPage(3);
                  }),
                ],
              )
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}

class BottomNavItem extends StatelessWidget {
  final String? image;
  final String? title;
  final VoidCallback? onTap;
  final bool? isSelected;
  final Color? color;
  const BottomNavItem({Key? key,  this.image, this.title, this.onTap, this.isSelected = false, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: 35,
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 3.0, color: isSelected! ? MyColor.colorPrimary : Colors.transparent)),
            ),
            child: SvgPicture.asset(image!, width: 24, height: 24, color: color,
            ),
          ),
          Text(title ?? '', style: robotoRegular.copyWith(color: isSelected! ? MyColor.colorPrimary : MyColor.colorGrey, fontSize: 11),)
        ],
      ),
    );
  }
}
