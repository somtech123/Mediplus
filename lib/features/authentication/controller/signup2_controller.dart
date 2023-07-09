import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp2Controller extends GetxController {
  RxString gender = ''.obs;

  void setGender(String type) {
    gender.value = type;
    debugPrint(gender.value);
  }
}
