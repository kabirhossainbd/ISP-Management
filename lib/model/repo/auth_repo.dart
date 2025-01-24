
import 'package:get/get.dart';
import 'package:isp_management/src/data/datasource/remote/http_client.dart';
import 'package:isp_management/utils/my_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login({required String email, required String password}) async {
    return await apiClient.postData('', {"email": email, "password": password});
  }




  // for  user token
  Future<void> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    try {
      await sharedPreferences.setString(MyKey.token, token);
    } catch (e) {
      rethrow;
    }
  }


  String getUserToken() {
    return sharedPreferences.getString(MyKey.token,) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(MyKey.token,);
  }


  Future<bool> clearSharedData() async {
    return sharedPreferences.remove(MyKey.token,);
    //return sharedPreferences.clear();
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(MyKey.userPass, password);
      await sharedPreferences.setString(MyKey.userEmail, number);
    } catch (e) {
      rethrow;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(MyKey.userEmail) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(MyKey.userPass) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(MyKey.userPass,);
    return await sharedPreferences.remove(MyKey.userEmail);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}
