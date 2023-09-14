import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utlis/time_model.dart';

class AppointmentController extends GetxController {
  Rx<Uint8List> imageBytes = Get.arguments;

  RxBool isSelected = false.obs;

  RxList<TimeModel> morningSlot = <TimeModel>[].obs;

  RxList<TimeModel> noonSlot = <TimeModel>[].obs;

  RxList<TimeModel> nightSlot = <TimeModel>[].obs;

  DateTime currentDate = DateTime.now();

  RxInt morningIndex = 0.obs;

  RxInt noonIndex = 0.obs;

  RxInt nightIndex = 0.obs;

  initialize() {
    morningSlot.value = TimeSlots.morningSlot;
    noonSlot.value = TimeSlots.noonSlot;
    nightSlot.value = TimeSlots.nightSlot;
  }

  selectNight(int index) {
    nightIndex.value = index;
    update();
  }

  selectNoon(int index) {
    noonIndex.value = index;
    update();
  }

  selectTime(int index) {
    morningIndex.value = index;
    update();
  }

  String getTime({required TimeOfDay time}) {
    DateTime dateTime = time.toDateTime(currentDate).toLocal();
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  void onReady() {
    initialize();
    super.onReady();
  }
}
