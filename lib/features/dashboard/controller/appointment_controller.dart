import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediplus/core/services/user/model/doctor_model.dart';

import '../../../core/shared_widgets/alert_widget.dart';
import '../../../core/utlis/time_model.dart';
import '../screen/patient_info.dart';

class AppointmentController extends GetxController {
  DoctorModel doc = Get.arguments;

  RxList<TimeOfDay> selectedDates = <TimeOfDay>[].obs;

  Rx<DateTime> currentDate = DateTime.now().obs;

  Rx<TimeOfDay> currentTime = TimeOfDay.now().obs;

  final RxBool _isSelectedTime = false.obs;

  final RxBool _isSelectedDate = false.obs;

  selectDate(DateTime date) {
    currentDate.value = date;

    _isSelectedDate.value = true;
  }

  String getTime({required TimeOfDay time}) {
    DateTime dateTime = time.toDateTime(DateTime.now()).toLocal();
    return DateFormat('h:mm a').format(dateTime);
  }

  void onTimeSelected(TimeOfDay date) {
    selectedDates.clear();

    _isSelectedTime.value = false;

    selectedDates.add(date);
    _isSelectedTime.value = true;

    currentTime.value = date;
  }

  bool isTimeSelected(TimeOfDay date) {
    return selectedDates.contains(date);
  }

  validate() {
    if (_isSelectedTime.value == false) {
      showErrorAlertWidget(Get.context!,
          message: 'please select appointment time');
      // ignore: unrelated_type_equality_checks
      // } else if (_isSelectedDate == false) {
      //   showErrorAlertWidget(Get.context!,
      //       message: 'please select appointment date');
    } else {
      Get.to(() => PatientInfoScreen());
    }
  }
}
