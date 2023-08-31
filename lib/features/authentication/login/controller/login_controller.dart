import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isVisible = true.obs;

  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  clearError(RxString val) => val.value = '';
  RxString emailErrorText = ''.obs;

  RxString passwordErrorText = ''.obs;

  validateInput() {
    if (!emailController.text.trim().isEmail) {
      emailErrorText.value = 'Incorrect email format';
    } else if (emailController.text.trim().isEmpty) {
      emailErrorText.value = 'Please enter your email';
    } else if (passwordController.text.trim().isEmpty) {
      passwordErrorText.value = 'Please enter your password';
    }
  }
}
