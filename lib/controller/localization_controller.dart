import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/utils/my_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController  extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = const Locale('en', 'US');
  bool _isLtr = true;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    _locale = locale;
    if(_locale.languageCode == 'en') {
      _isLtr = false;
    }else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    Get.updateLocale(locale);
    update();
  }

  int _languageIndex = 0;
  int get languageIndex => _languageIndex;

  // setLanguageIndex(int index, bool notify){
  //   _languageIndex = index;
  //   if(notify){
  //     update();
  //   }
  // }

  void toggleLanguage() {
    if(_locale.languageCode == 'en') {
      _languageIndex = 0;
      _locale = const Locale('ar', 'SA');
      _isLtr = false;
    }else {
      _languageIndex = 1;
      _locale = const Locale('en', 'US');
      _isLtr = true;
    }
    _saveLanguage(_locale);
    Get.updateLocale(locale);
    update();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(MyKey.languageCode) ?? 'de',
        sharedPreferences.getString(MyKey.countryCode) ?? 'US');
    _isLtr = _locale.languageCode == 'en';
    update();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(MyKey.languageCode, locale.languageCode);
    sharedPreferences.setString(MyKey.countryCode, locale.countryCode!);
  }

}