import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mediplus/env/private_key.dart';
import 'package:mediplus/features/dashboard/controller/appointment_controller.dart';

import '../../../core/services/user/usecase.dart';
import '../../../core/shared_widgets/alert_widget.dart';
import '../../../core/shared_widgets/loading_widgets.dart';
import '../screen/payment_screen.dart';

class PatientInfoController extends GetxController {
  RxList<PlatformFile> file = <PlatformFile>[].obs;

  var _ctr = Get.find<AppointmentController>();

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  final RxList<File> _file = <File>[].obs;

  final UserServices _userServices = UserServices();

  var nameController = TextEditingController();

  var descriptionController = TextEditingController();

  var weightController = TextEditingController();

  var dateController = TextEditingController();
  var phoneController = TextEditingController();

  clearError(RxString val) => val.value = '';

  RxString nameErrorText = ''.obs;
  RxString phoneErrorText = ''.obs;

  RxString descriptionErrorText = ''.obs;

  RxString dateErrorText = ''.obs;

  RxString weightErrorText = ''.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value.subtract(const Duration(days: 1)),
      firstDate: DateTime(1930),
      lastDate: selectedDate.value.subtract(const Duration(days: 1)),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate.value = picked;

      dateController.text = '${picked.day}-${picked.month}-${picked.year}';
      dateErrorText.value = '';
    }
  }

  pickMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      file.value = result.files;
      _file.value = result.paths.map((e) => File(e!)).toList();
    } else {
      return;
    }
  }

  validateInput() {
    if (nameController.text.trim().isEmpty) {
      nameErrorText.value = 'This Field is required';
    } else if (dateController.text.isEmpty) {
      dateErrorText.value = 'This field is required';
    } else if (weightController.text.trim().isEmpty) {
      weightErrorText.value = 'This Field is required';
    } else if (descriptionController.text.isEmpty) {
      descriptionErrorText.value = 'This Field is required';
    } else if (phoneController.text.trim().isEmpty) {
      showErrorAlertWidget(Get.context!,
          message: 'Please enter your phone number', title: 'An error occured');
    } else if (!phoneController.text.isNumericOnly) {
      showErrorAlertWidget(Get.context!,
          message: 'Invalid phone number format', title: 'An Error occured');
    } else {
      bookAppointment();
    }
  }

  bookAppointment() async {
    showLoading(Get.context!);

    String res = await _verifyInfo();

    if (res == 'success') {
      Get.to(() => PaymentScreen(), arguments: _ctr.doc);
    } else {
      Get.back();
      showErrorAlertWidget(Get.context!, message: res);
    }
  }

  Future<String> _verifyInfo() async {
    String res = "Some error occurred";

    try {
      if (file.isNotEmpty) {
        List<String> fileUrl = await _userServices.uploadFiles(_file);

        Map<String, dynamic> _payload() => {
              'patient_name': nameController.text,
              'doctor_id': _ctr.doc.id,
              'doctor_firstname': _ctr.doc.firstname,
              'doctor_lastname': _ctr.doc.lastname,
              'specialtist': _ctr.doc.specialist,
              'doctor_photo': _ctr.doc.photo,
              'SN': generateAppointmentNuber(),
              'payment_status': PrivateKey.paymentStatus,
              "patient_DOB": selectedDate.value.toIso8601String(),
              'patient_weight': weightController.text,
              'patient_phone': phoneController.text,
              'status': PrivateKey.appointmentStatus,
              'appointment_description': descriptionController.text,
              'appointment_date': _ctr.currentDate.value.toIso8601String(),
              'appointment_time': DateTime(
                      _ctr.currentDate.value.year,
                      _ctr.currentDate.value.month,
                      _ctr.currentDate.value.day,
                      _ctr.currentTime.value.hour,
                      _ctr.currentTime.value.minute)
                  .toIso8601String(),
              //_timeToFirebase(_ctr.currentTime.value),
              'report': fileUrl,
              'date_created': DateTime.now().toIso8601String()
            };

        await _db.ref().child('appointments').push().set(_payload());
        res = 'success';
      } else {
        await _db.ref().child('appointments').push().set(payload());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  _timeToFirebase(TimeOfDay timeOfDay) =>
      {'hour': timeOfDay.hour, 'minutes': timeOfDay.minute};

  Map<String, dynamic> payload() => {
        'patient_name': nameController.text,
        'doctor_firstname': _ctr.doc.firstname,
        'doctor_id': _ctr.doc.id,
        'doctor_lastname': _ctr.doc.lastname,
        'specialtist': _ctr.doc.specialist,
        'doctor_photo': _ctr.doc.photo,
        'SN': generateAppointmentNuber(),
        'payment_status': PrivateKey.paymentStatus,
        "patient_DOB": selectedDate.value.toIso8601String(),
        'patient_weight': weightController.text,
        'patient_phone': phoneController.text,
        'appointment_description': descriptionController.text,
        'appointment_date': _ctr.currentDate.value.toIso8601String(),
        'status': PrivateKey.appointmentStatus,
        'appointment_time': DateTime(
                _ctr.currentDate.value.year,
                _ctr.currentDate.value.month,
                _ctr.currentDate.value.day,
                _ctr.currentTime.value.hour,
                _ctr.currentTime.value.minute)
            .toIso8601String(),
        'report': [],
        'date_created': DateTime.now().toIso8601String()
      };

  String generateAppointmentNuber() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int random = Random().nextInt(9000) + 1000;
    String appointmentNumber = 'SN$timestamp$random';

    return appointmentNumber;
  }
}
