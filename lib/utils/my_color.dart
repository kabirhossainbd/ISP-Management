import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/theme_controller.dart';

class MyColor {
  static Color getPrimaryColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF00A884, ) : const Color(0xFF00A884);
  }

  static Color getSecondaryColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xff28347C) : const Color(0xff011C4B);
  }
  static Color getGreyColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF6f7275) : const Color(0xFF999999);
  }

  static Color getBackgroundColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xff25282B) : const Color(0xFFF8F8F8);
  }

  static Color getBorderColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF525257) : const Color(0xFFE9E9E9);
  }

  static Color getBottomSheetColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF25282B) : const Color(0xFFF4F7FC);
  }

  static Color getHintColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF98a1ab) : const Color(0xFF52575C);
  }

  static Color getTextColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  }

  static Color getRedColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFD10D2F).withOpacity(0.8) : const Color(0xFFD32F2F);
  }

  static Color getDarkColor() {
    return Get.find<ThemeController>().darkTheme  ? const Color(0xFF4d5054) : const Color(0xFF25282B);
  }
  static Color getWhiteBlackColor(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }
  static Color getSurfaceColor(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF2C2C2E) : const Color(0xFFFFFFFF);
  }

  static Color getHistoryColor(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFE6F6F3).withOpacity(0.2) : const Color(0xFFE6F6F3);
  }

  static Color getCardColor(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF2C2C2E) : const Color(0xFFE6FBF7);
  }
  static Color getChatBoxColor(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF1C1C1E) : const Color(0xFFECE5DD);
  }

  static Color getSenderBox(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF00A884) : const Color(0xFFDCF8C6);
  }


  static const Color colorPrimary = Color(0xFF00A884);
  static  Color colorSecondary = const Color(0xFF00A67E).withOpacity(0.4);
  static const Color colorChatBg = Color(0xFFDCF8C6);
  static const Color colorGrey = Color(0xFF999999);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorLightBlack = Color(0xFFE9E9E9);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorHint = Color(0xFF52575C);
  static const Color colorGreen = Color(0xFF2AAE48);
  static const Color colorCard = Color(0xffE8E8E8);
  static const Color colorGreyBunker = Color(0xff25282B);
  static const Color colorRed = Color(0xFFD32F2F);
  static const Color colorYellow = Color(0xFFFACC15);
  static const Color colorPurple = Color(0xFF800080);
  static const Color colorBackground = Color(0xFFF8F8F8);
  static const Color colorBorder = Color(0xFFEEEEEE);
  static const Color colorLine = Color(0x00000014);

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };
}
