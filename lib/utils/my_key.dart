import 'package:isp_management/model/response/language_model.dart';

class MyKey {
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String userPass = 'userPass';
  static const String userEmail = 'userEmail';


  static List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}