import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/gloalctr.dart';
import '../../../core/services/user/model/doctor_model.dart';
import '../../../core/services/user/usecase.dart';

class DashboardController extends GetxController {
  final UserServices _userServices = UserServices();

  var globalCtr = Get.find<GlobalController>();

  Future<List<DoctorModel>> getAllDoctors() async {
    return await _userServices.getAllDoctors();
  }
}
