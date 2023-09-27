import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/gloalctr.dart';
import '../../../core/services/user/model/appointment_model.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/shared_widgets/alert_widget.dart';
import '../../../core/shared_widgets/loading_widgets.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../bottom_tab/screen/bottom_tab.dart';

class ReviewController extends GetxController {
  UserServices _userServices = UserServices();

  AppointmentModel appointment = Get.arguments;

  var globalCtr = Get.find<GlobalController>();

  RxDouble rating = 0.0.obs;

  RxString commentError = ''.obs;

  var commentController = TextEditingController();

  clearError(RxString val) => val.value = '';

  validate() {
    if (commentController.text.trim().isEmpty) {
      commentError.value = 'Please leave a comment';
    } else {
      sendReview();
    }
  }

  Map<String, dynamic> payload() => {
        'fistname': globalCtr.user.value.firstName,
        'lastname': globalCtr.user.value.lastName,
        'photoUrl': globalCtr.user.value.profileImage,
        'rating': rating.value.toString(),
        'comment': commentController.text,
        'date_created': DateTime.now().toIso8601String()
      };

  sendReview() async {
    showLoading(Get.context!);

    String res = await _userServices.sendReview(
        payload: payload(),
        docId: appointment.doctorId,
        userId: globalCtr.user.value.id);
    if (res == 'success') {
      Get.offAll(() => BottomTab());

      showSuccessSnackBar('Review', 'Review Sent Successfully');
    } else {
      Get.back();
      showErrorAlertWidget(Get.context!, message: res);
    }
  }
}
