import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:isp_management/src/view/screens/splash_screen.dart';

class MyRouteHelper {
  static const String splashScreen = '/splash';
  static const String home = '/home';
  static const String onBoarding = '/onBoarding';
  static const String dashboard = '/';
  static const String successfulScreen = '/successful';
  static const String productDetails = '/product-branch';
  static const String searchResult = '/search-result';
  static const String searchScreen = '/search';
  static const String notification = '/notification';
  static const String favourite = '/favourite';

  static String getSplashRoute() => splashScreen;

  static String getOnBoardingRoute() => onBoarding;

  static String getMainRoute() => dashboard;

  static String getHomeRoute() => home;


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () =>  const SplashScreen()),
    GetPage(name: onBoarding, page: () => Container()),
    GetPage(name: dashboard, page: () => Container()),
    GetPage(name: home, page: () => Container()),
  ];
}
