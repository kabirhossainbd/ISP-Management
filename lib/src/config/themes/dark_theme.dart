import 'package:flutter/material.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_style.dart';


ThemeData dark = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: MyColor.colorPrimary,
    primaryColorLight: MyColor.colorPrimary,
    primaryColorDark: MyColor.colorPrimary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: MyColor.colorBackground,
    hintColor: MyColor.colorWhite,
    focusColor: MyColor.colorGrey,
    /// for text color
    canvasColor: MyColor.colorWhite,
    /// for bg
    highlightColor: MyColor.colorBlack,
    buttonTheme:  const ButtonThemeData(
      buttonColor: MyColor.colorPrimary,
    ),
    cardColor: MyColor.colorCard,
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.colorBackground,
        elevation: 0,
        titleTextStyle: robotoRegular.copyWith(color: MyColor.colorWhite),
        iconTheme:  const IconThemeData(
            size: 20,
            color: MyColor.colorWhite
        )
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.colorWhite),
      overlayColor: MaterialStateProperty.all(MyColor.colorPrimary),
    ));