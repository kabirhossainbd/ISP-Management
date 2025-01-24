import 'package:flutter/material.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_style.dart';

ThemeData light = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: MyColor.colorPrimary,
    primaryColorLight: MyColor.colorPrimary,
    primaryColorDark: MyColor.colorPrimary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MyColor.colorGrey.withOpacity(0.3),
    hintColor: MyColor.colorBlack,
    /// for text color
    canvasColor: MyColor.colorBlack,
    /// for bg
    highlightColor: MyColor.colorWhite,
    buttonTheme: const ButtonThemeData(
      buttonColor: MyColor.colorPrimary,
    ),
    cardColor: MyColor.colorCard,
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.colorPrimary,
        elevation: 0,
        titleTextStyle: robotoRegular.copyWith(color: MyColor.colorWhite),
        iconTheme:  const IconThemeData(
            size: 20,
            color: MyColor.colorWhite,
        )
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.colorPrimary),
    ),
);
