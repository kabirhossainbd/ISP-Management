import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/auth_controller.dart';
import 'package:isp_management/src/view/screens/auth/auth.dart';
import 'package:isp_management/src/view/screens/dashboard/dashboard_screen.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _route();
  }

  void _route() {
    Timer(const Duration(seconds: 2), () async {
      if (Get.find<AuthController>().getUserEmail().contains('demo@gmail.com') && Get.find<AuthController>().getUserPassword().contains('123456') ) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashboardScreen()));
       // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CustomerScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(MyImage.splashWifi, fit: BoxFit.scaleDown),
          ),
        ],
      )
    );
  }
}

