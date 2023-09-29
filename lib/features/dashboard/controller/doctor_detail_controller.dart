import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/apiclient.dart';
import '../../../core/gloalctr.dart';
import '../../../core/services/user/model/doctor_model.dart';
import '../../../core/shared_widgets/alert_widget.dart';

class DoctorDetailController extends GetxController {
  RxBool isLoading = true.obs;
  DoctorModel doc = Get.arguments;

  ScreenshotController screenshotController = ScreenshotController();

  Future takeScreenshot() async {
    final imageBytes = await screenshotController.capture();

    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png');
      await imagePath.writeAsBytes(imageBytes);

      await Share.shareXFiles([XFile(imagePath.path)]);
    } else {
      print('Screenshot capture failed');
    }
  }

  Rx<Uint8List> bodyBytes = Uint8List(0).obs;

  var globalCtr = Get.find<GlobalController>();

  Future<Uint8List> removeImg() async {
    isLoading.value = true;
    final res =
        await ApiClient().removeImageBackground("assets/images/doc1.jpg");
    bodyBytes.value = res;
    isLoading.value = false;
    return res;
  }

  Future<void> launchPhoneDialer() async {
    if (doc.phone != null) {
      final Uri uri = Uri(scheme: "tel", path: doc.phone);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        showErrorAlertWidget(Get.context!,
            message: "Cannot launch dialer at this time");
      }
    }
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
