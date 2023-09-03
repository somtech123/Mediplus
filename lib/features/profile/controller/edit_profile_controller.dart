import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/utlis/country_model.dart';
import '../../../core/utlis/country_state_utlis.dart';

class EditProfileController extends GetxController {
  RxString gender = ''.obs;

  RxString dateErrorText = ''.obs;

  RxString phoneErrorText = ''.obs;

  RxString fnameErrorText = ''.obs;

  RxString lnameErrorText = ''.obs;

  RxString usernamenameErrorText = ''.obs;

  var fnameController = TextEditingController();

  var lnameController = TextEditingController();

  var usernamenameController = TextEditingController();

  var phoneController = TextEditingController();

  Rx<DateTime> selectedDate = DateTime.now().obs;

  var dateController = TextEditingController();

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

  void onStateSelected(String city) {
    selectedState.value = city;
  }

  void setGender(String type) {
    gender.value = type;
  }

  clearError(RxString val) => val.value = '';

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

  validate() {
    if (fnameController.text.trim().isEmpty) {
      fnameErrorText.value = 'This field is required';
    }
  }

  @override
  void onReady() {
    loadLocations();
    super.onReady();
  }
}
