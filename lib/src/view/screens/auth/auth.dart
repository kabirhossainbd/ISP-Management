import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/auth_controller.dart';
import 'package:isp_management/src/view/base/custom_text_filed.dart';
import 'package:isp_management/src/view/base/custom_toast.dart';
import 'package:isp_management/src/view/screens/dashboard/dashboard_screen.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final FocusNode _accountNumberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  late TextEditingController _accountNumberController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;
  @override
  void initState() {

    _formKeyLogin = GlobalKey<FormState>();
    _accountNumberController = TextEditingController();
    _passwordController = TextEditingController();
   // _accountNumberController.text = Provider.of<AuthProvider>(context, listen: false).getUserEmail() ?? '';
   // _passwordController.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? '';

    super.initState();
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getBackgroundColor(),
      resizeToAvoidBottomInset: true,
      body: GetBuilder<AuthController>(
        builder: (authProvider) => Form(
          key: _formKeyLogin,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [

                Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(MyImage.splashWifi, fit: BoxFit.scaleDown, height: 300, width: 300),
                ),

                Align(alignment: Alignment.center,child: Text('ISP.net', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 40),)),
                const SizedBox(height: MySizes.paddingSizeSmall),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomTextField(
                    hintTxt: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: _accountNumberFocus,
                    nextNode: _passwordFocus,
                    isEmail: true,
                    controller: _accountNumberController,
                  ),
                ),
                const SizedBox(height: MySizes.paddingSizeLarge),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  child: CustomPassField(
                    hintTxt: 'Password',
                    textInputAction: TextInputAction.done,
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(height: MySizes.paddingSizeLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text('*Credential', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: 14),),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Text('demo@gmail.com', style: robotoRegular.copyWith(color: MyColor.getGreyColor(), fontSize: 12)),
                      const SizedBox(width: 12),
                      Text('123456', style: robotoRegular.copyWith(color: MyColor.getGreyColor(), fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: MySizes.paddingSizeLarge),




                !authProvider.isLoading ? Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async{
                      String email = _accountNumberController.text.trim();
                      String password = _passwordController.text.trim();

                      if (email.isEmpty) {
                        showSnackBar('Enter Email Address');
                      } else if (!GetUtils.isEmail(email)) {
                        showSnackBar('Enter Valid Email');
                      } else if (password.isEmpty) {
                        showSnackBar('Enter Password');
                      }else if (password.length < 6) {
                        showSnackBar('Password Should Be 6');

                        }else {
                        if(email == 'demo@gmail.com' && password == '123456'){
                          authProvider.saveUserNumberAndPassword(email, password);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardScreen()), (route) => false);
                          showSnackBar('Login Successfully Done!');
                          }else{
                          showSnackBar('Login Failed');
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeLarge, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: MyColor.colorBlack, width: 1),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text('LogIn', style: robotoBold.copyWith(color: MyColor.colorBlack),),
                    ),
                  ),
                ) : Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(MyColor.colorPrimary),
                  ),
                ),
                const SizedBox(height: 52),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

