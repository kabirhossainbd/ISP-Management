import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/auth_controller.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/controller/home_controller.dart';
import 'package:isp_management/controller/localization_controller.dart';
import 'package:isp_management/controller/package_controller.dart';
import 'package:isp_management/controller/theme_controller.dart';
import 'package:isp_management/model/repo/auth_repo.dart';
import 'package:isp_management/model/repo/customer_repo.dart';
import 'package:isp_management/model/repo/home_repo.dart';
import 'package:isp_management/model/repo/package_repo.dart';
import 'package:isp_management/model/response/language_model.dart';
import 'package:isp_management/src/data/datasource/remote/http_client.dart';
import 'package:isp_management/src/view/screens/chat/custom_popup/custom_popup.dart';
import 'package:isp_management/utils/my_key.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, Map<String, String>>> init() async {

  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: '',  sharedPreferences: Get.find()));


  /// Request
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PackageRepo());
  Get.lazyPut(() => HomeRequest(apiSource: Get.find()));
  Get.lazyPut(() => CustomerRepo());


  /// Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PackageController(packageRepo: Get.find()));
  Get.lazyPut(() => CustomerController(customerRepo: Get.find()));
  Get.lazyPut(() => HomeController(homeRequest: Get.find()));
  Get.lazyPut(() => CustomPopupMenuController());


  /// read from json file
  Map<String, Map<String, String>> langFiles = {};
  for(LanguageModel languageModel in MyKey.languages) {
    String jsonToString =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonToString);
    Map<String, String> convertToJson = {};
    mappedJson.forEach((key, value) {
      convertToJson[key] = value.toString();
    });
    langFiles['${languageModel.languageCode}_${languageModel.countryCode}'] = convertToJson;
  }
  return langFiles;
}

