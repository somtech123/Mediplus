import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage/storage.dart';
import '../../../core/services/user/model/doctor_model.dart';
import '../../../core/services/user/usecase.dart';

class ExploreController extends GetxController {
  RxList<DoctorModel> user = <DoctorModel>[].obs;
  final _userServices = UserServices();

  final _storageService = StorageService();

  final TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    loadUserList();

    super.onInit();
  }

  Future<List<DoctorModel>> search(String query) async {
    user.value = await _userServices.searchDoctor(query);
    saveRentUserSearch(user);
    return user;
  }

  Future<void> saveRentUserSearch(List<DoctorModel> userList) async {
    Set<String> userJsonList =
        userList.map((user) => json.encode(user.toJson())).toSet();

    await _storageService.setRecentSearch(userJsonList);
  }

  Future<List<DoctorModel>> loadUserList() async {
    List<String> userJsonList = await _storageService.getrecentSearch();

    user.value = userJsonList.map((userJson) {
      Map<String, dynamic> userMap = json.decode(userJson);
      return DoctorModel.fromJson(userMap);
    }).toList();
    debugPrint(user.toString());

    return user;
  }
}
