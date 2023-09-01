import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSuccessSnackBar(String title, String message) {
  Get.snackbar(title, message,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: Colors.white,
      colorText: Colors.green,
      duration: const Duration(seconds: 2));
}

showNoticeSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    borderRadius: 10,
    duration: const Duration(seconds: 4),
    margin: const EdgeInsets.symmetric(horizontal: 30),
    backgroundColor: const Color(0xFF085776).withOpacity(.5),
    colorText: Colors.white,
  );
}

showErrorSnackBar(String title, String message) async {
  Get.snackbar(title, message,
      icon: const Icon(
        Icons.error_outlined,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: Colors.red.withOpacity(.5),
      colorText: Colors.white,
      duration: const Duration(seconds: 5));
}
