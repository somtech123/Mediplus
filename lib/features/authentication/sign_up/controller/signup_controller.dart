import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/authentication/sign_up/view/signup2_screen.dart';

class SignupController extends GetxController {
  final alphaRegex = RegExp(r'[a-zA-Z]');
  final numberRegex = RegExp(r'^[0-9]$');

  RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$');

  RxBool isVisible = true.obs;

  clearError(RxString val) => val.value = '';

  RxString fnameErrorText = ''.obs;

  RxString lnameErrorText = ''.obs;

  RxString emailErrorText = ''.obs;

  RxString usernameError = ''.obs;

  RxString passwordErrorText = ''.obs;

  var fnameController = TextEditingController();

  var lnameController = TextEditingController();

  var emailController = TextEditingController();

  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  validateInput() {
    if (fnameController.text.trim().isEmpty) {
      fnameErrorText.value = 'Please enter your first name';
    } else if (lnameController.text.trim().isEmpty) {
      lnameErrorText.value = 'Please enter your last name';
    } else if (!emailController.text.trim().isEmail) {
      emailErrorText.value = 'Incorrect email format';
    } else if (emailController.text.trim().isEmpty) {
      emailErrorText.value = 'Please enter your email';
    } else if (usernameController.text.trim().isEmpty) {
      usernameError.value = 'Please enter your username';
    } else if (passwordController.text.trim().isEmpty) {
      passwordErrorText.value = 'Please enter your password';
    } else if (!passwordController.value.text.contains(passwordRegex)
        //  &&
        //     !passwordController.value.text.contains(numberRegex)
        ) {
      passwordErrorText.value = "Password should contain numbers and alphabets";
    } else if (passwordController.text.length < 6) {
      passwordErrorText.value =
          "Password should contain more than 6 characters";
    } else {
      Get.to(() => SignUpTwoScreen());
    }
  }
}
