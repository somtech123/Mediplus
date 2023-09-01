import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/authentication/usecase.dart';
import '../../../../core/shared_widgets/alert_widget.dart';
import '../../../../core/shared_widgets/loading_widgets.dart';
import '../../../bottom_tab/screen/bottom_tab.dart';

class LoginController extends GetxController {
  final AuthServices _authservices = AuthServices();

  RxBool isVisible = true.obs;

  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  clearError(RxString val) => val.value = '';
  RxString emailErrorText = ''.obs;

  RxString passwordErrorText = ''.obs;

  googleSigin() async {
    showLoading(Get.context!);

    String res = await _authservices.signInWithGoogle();
    Get.back();
    if (res == 'success') {
      Get.offAll(() => BottomTab());
    } else {
      showErrorAlertWidget(Get.context!, message: res);
    }
  }

  facebookSigin() async {
    showLoading(Get.context!);

    String res = await _authservices.signInWithFacebook();
    Get.back();
    if (res == 'success') {
      Get.offAll(() => BottomTab());
    } else {
      showErrorAlertWidget(Get.context!, message: res);
    }
  }

  login() async {
    showLoading(Get.context!);
    String res = await _authservices.loginUser(
        passwordController.text, emailController.text);
    Get.back();
    if (res == 'success') {
      Get.offAll(() => BottomTab());
    } else {
      showErrorAlertWidget(Get.context!, message: res);
    }
  }

  validateInput() {
    if (!emailController.text.trim().isEmail) {
      emailErrorText.value = 'Incorrect email format';
    } else if (emailController.text.trim().isEmpty) {
      emailErrorText.value = 'Please enter your email';
    } else if (passwordController.text.trim().isEmpty) {
      passwordErrorText.value = 'Please enter your password';
    } else {
      login();
    }
  }
}
