import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/shared_widgets/alert_widget.dart';
import '../../../../core/utlis/country_model.dart';
import '../../../../core/utlis/country_state_utlis.dart';

class SignUp2Controller extends GetxController {
  RxString gender = ''.obs;

  var phoneController = TextEditingController();

  Rx<DateTime> selectedDate = DateTime.now().obs;

  var dateController = TextEditingController();

  RxString phoneErrorText = ''.obs;

  RxString dateErrorText = ''.obs;

  void setGender(String type) {
    gender.value = type;
    debugPrint(gender.value);
  }

  RxList<CountryModel> location = <CountryModel>[].obs;

  RxString selectedCountry = 'Nigeria'.obs;
  RxString selectedState = ''.obs;

  void loadLocations() async {
    location.value = AppCountry.country;

    selectedState.value = location
        .firstWhere(
          (element) => element.country == selectedCountry.value,
          orElse: () => CountryModel(states: [], country: '', alpha2code: ''),
        )
        .states
        .first;
  }

  void onCountrySelected(String country) {
    selectedCountry.value = country;
    selectedState.value = location
        .firstWhere((element) => element.country == country)
        .states
        .first;

    update();
  }

  clearError(RxString val) => val.value = '';
  void onStateSelected(String city) {
    selectedState.value = city;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value.subtract(const Duration(days: 1)),
      firstDate: DateTime(1930),
      lastDate: selectedDate.value.subtract(const Duration(days: 1)),
      //DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate.value = picked;

      dateController.text = '${picked.day}-${picked.month}-${picked.year}';
      dateErrorText.value = '';
    }
  }

  validateInput() {
    if (phoneController.text.trim().isEmpty) {
      showErrorAlertWidget(Get.context!,
          message: 'Please enter your phone number', title: 'An error occured');
    } else if (!phoneController.text.isNumericOnly) {
      showErrorAlertWidget(Get.context!,
          message: 'Invalid phone number format', title: 'An Error occured');
    } else if (dateController.text.isEmpty) {
      dateErrorText.value = 'This field is required';
    }
  }

  @override
  void onReady() {
    loadLocations();
    super.onReady();
  }
}
