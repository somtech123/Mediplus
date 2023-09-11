import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/services/authentication/model/user_model.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/shared_widgets/alert_widget.dart';
import '../../../core/shared_widgets/loading_widgets.dart';
import '../../../core/utlis/country_model.dart';
import '../../../core/utlis/country_state_utlis.dart';
import '../../bottom_tab/screen/bottom_tab.dart';

class EditProfileController extends GetxController {
  final UserServices _userServices = UserServices();
  RxString gender = ''.obs;

  Rx<UserModel> user = UserModel().obs;

  RxString dateErrorText = ''.obs;

  RxString phoneErrorText = ''.obs;

  RxString fnameErrorText = ''.obs;

  RxString lnameErrorText = ''.obs;

  RxString usernamenameErrorText = ''.obs;

  var fnameController = TextEditingController();

  var lnameController = TextEditingController();

  var usernamenameController = TextEditingController();

  var phoneController = TextEditingController();

  validate() {
    if (fnameController.text.trim().isEmpty) {
      fnameErrorText.value = 'This field is required';
    } else if (lnameController.text.trim().isEmpty) {
      lnameErrorText.value = 'This field is required';
    } else if (usernamenameController.text.trim().isEmpty) {
      usernamenameErrorText.value = 'This field is required';
    } else if (phoneController.text.trim().isEmpty) {
      phoneErrorText.value = 'This field is required';
    } else if (dateController.text.trim().isEmpty) {
      dateErrorText.value = 'This field is required';
    } else if (gender.value.trim().isEmpty) {
      showErrorAlertWidget(Get.context!, message: 'gender is required');
    } else {
      updateProfile();
    }
  }

  updateProfile() async {
    showLoading(Get.context!);

    String res = await _userServices.updateUserProfile(
      UserModel(
          userName: usernamenameController.text,
          firstName: fnameController.text,
          lastName: lnameController.text,
          birthDate: selectedDate.value,
          country: selectedCountry.value,
          state: selectedState.value,
          phone: phoneController.text,
          gender: gender.value),
    );

    Get.back();

    if (res == 'success') {
      Get.offAll(() => BottomTab());
    } else {
      Get.back();
      showErrorAlertWidget(Get.context!, message: res);
    }
  }

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

  Future<UserModel> getUserDetail() async {
    user.value = await _userServices.getUserDetails();
    initializeController(user.value);

    return user.value;
  }

  initializeController(UserModel user) async {
    usernamenameController.text = user.userName!;
    lnameController.text = user.lastName!;
    fnameController.text = user.firstName!;
    gender.value = user.gender!;
    phoneController.text = user.phone!;
    // dateController.text =
    // DateFormat.yMd(user.birthDate!);
    if (user.country!.isNotEmpty && user.state!.isNotEmpty) {
      setInitialLocations(user.country!, user.state!);
    }
  }

  void setInitialLocations(String _country, String _city) {
    var state =
        location.value.singleWhere((element) => element.country == _country);

    selectedCountry.value = state.country;
    selectedState.value = state.states.singleWhere((e) => e == _city);
  }

  @override
  void onReady() {
    loadLocations();
    getUserDetail();
    super.onReady();
  }
}
