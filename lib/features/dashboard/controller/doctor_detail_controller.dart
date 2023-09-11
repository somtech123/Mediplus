import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/api/apiclient.dart';

class DoctorDetailController extends GetxController {
  RxBool isLoading = true.obs;

  Rx<Uint8List> bodyBytes = Uint8List(0).obs;

  Future<Uint8List> removeImg() async {
    isLoading.value = true;
    final res =
        await ApiClient().removeImageBackground("assets/images/doc1.jpg");
    bodyBytes.value = res;
    isLoading.value = false;
    return res;
  }

  @override
  void onReady() {
    removeImg();
    super.onReady();
  }
}
