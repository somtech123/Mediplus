import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediplus/core/services/user/model/doctor_model.dart';

import '../../../core/utlis/time_model.dart';

class AppointmentController extends GetxController {
  DoctorModel doc = Get.arguments;

  RxList<TimeOfDay> selectedDates = <TimeOfDay>[].obs;

  DateTime currentDate = DateTime.now();

  String getTime({required TimeOfDay time}) {
    DateTime dateTime = time.toDateTime(currentDate).toLocal();
    return DateFormat('h:mm a').format(dateTime);
  }

  void onTimeSelected(TimeOfDay date) {
    selectedDates.clear();

    selectedDates.add(date);

    debugPrint(selectedDates.length.toString());
  }

  bool isTimeSelected(TimeOfDay date) {
    return selectedDates.contains(date);
  }

  @override
  void onReady() {
    //  initialize();
    super.onReady();
  }
}
