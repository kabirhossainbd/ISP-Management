import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/localization_controller.dart';
import 'package:isp_management/controller/theme_controller.dart';
import 'package:isp_management/service/local_string.dart';
import 'package:isp_management/src/config/route/my_route.dart';
import 'package:isp_management/src/config/themes/dark_theme.dart';
import 'package:isp_management/src/config/themes/light_theme.dart';
import 'package:isp_management/src/config/themes/m_theme_util.dart';
import 'package:isp_management/utils/my_string.dart';
import 'src/view/locator.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeUtil.allScreenTheme();
  await di.init();
  Map<String, Map<String, String>> localString = await di.init();
  runApp( MyApp(localString: localString,));
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final Map<String, Map<String, String>> localString;
  const MyApp({Key? key, required this.localString}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (theme) {
      return GetBuilder<LocalizationController>(builder: (local) {
        return GetMaterialApp(
          locale: local.locale,
          // locale: Get.deviceLocale,
          translations: LocaleString(localString: widget.localString),
          fallbackLocale: const Locale('en', 'US'),
          title: MyStrings.appName,
          initialRoute: MyRouteHelper.splashScreen,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
          getPages: MyRouteHelper.routes,
          navigatorKey: Get.key,
          theme: theme.darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
        );
      });
    });
  }
}