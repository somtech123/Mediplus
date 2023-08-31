import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp2Controller extends GetxController {
  RxString gender = ''.obs;

  var phoneController = TextEditingController();

  RxString phoneErrorText = ''.obs;

  void setGender(String type) {
    gender.value = type;
    debugPrint(gender.value);
  }
}
