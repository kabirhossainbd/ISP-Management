import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String message){
  Get.showSnackbar(GetSnackBar(
    backgroundColor: Colors.black.withOpacity(0.8),  message: message,
    maxWidth: 1170,  duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,  margin: const EdgeInsets.fromLTRB(5, 5,5,20),
    borderRadius: 6,  isDismissible: true,
    snackPosition: SnackPosition.TOP,
    dismissDirection: DismissDirection.horizontal,));
}