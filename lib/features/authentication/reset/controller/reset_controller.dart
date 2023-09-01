import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/authentication/usecase.dart';
import '../../../../core/shared_widgets/alert_widget.dart';
import '../../../../core/shared_widgets/loading_widgets.dart';
import '../../../../core/shared_widgets/snack_bar.dart';
import '../../login/view/login.dart';

class ResetController extends GetxController {
  final AuthServices _authservices = AuthServices();

  var emailController = TextEditingController();

  clearError(RxString val) => val.value = '';
  RxString emailErrorText = ''.obs;

  resetPassword() async {
    showLoading(Get.context!);
    String res = await _authservices.resetPassword(emailController.text);
    Get.back();
    if (res == 'success') {
      showSuccessSnackBar(
          "Reset Password", "Password resent link has been sent to your email");
      Get.offAll(() => LoginScreen());
    } else {
      showErrorAlertWidget(Get.context!, message: res);
    }
  }

  validateInput() {
    if (!emailController.text.trim().isEmail) {
      emailErrorText.value = 'Incorrect email format';
    } else if (emailController.text.trim().isEmpty) {
      emailErrorText.value = 'Please enter your email';
    } else {
      resetPassword();
    }
  }
}
