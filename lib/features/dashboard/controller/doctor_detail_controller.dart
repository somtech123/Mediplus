import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/api/apiclient.dart';
import '../../../core/services/user/model/doctor_model.dart';

class DoctorDetailController extends GetxController {
  RxBool isLoading = true.obs;
  DoctorModel doc = Get.arguments;

  Rx<Uint8List> bodyBytes = Uint8List(0).obs;

  Future<Uint8List> removeImg() async {
    isLoading.value = true;
    final res =
        await ApiClient().removeImageBackground("assets/images/doc1.jpg");
    bodyBytes.value = res;
    isLoading.value = false;
    return res;
  }

  int calculateYear(DateTime date) {
    final from = DateTime.now();
    return from.year - date.year;
  }

  @override
  void onReady() {
    // removeImg();
    super.onReady();
  }
}
