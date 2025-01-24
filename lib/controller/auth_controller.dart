import 'package:get/get.dart';
import 'package:isp_management/model/repo/auth_repo.dart';
import 'package:isp_management/model/response/response_model.dart';


class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get isLoading => _isLoading;




  void setFirstTimeConnectionCheck(bool isChecked){
    _firstTimeConnectionCheck = isChecked;
  }

  // for login section
  String _loginErrorMessage = '';
  String get loginErrorMessage => _loginErrorMessage;

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
   update();
    Response response = await authRepo.login(email: email, password: password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      Map map = response.body;
      String token = map["access_token"];
      authRepo.saveUserToken(token);
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage = '';
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // for Remember Me Section
  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
   update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserEmail() {
    return authRepo.getUserEmail();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  Future<bool> removeSharedData() {
    return authRepo.removeSharedData();
  }

}
