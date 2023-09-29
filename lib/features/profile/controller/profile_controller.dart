import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/authentication/model/user_model.dart';
import '../../../core/services/authentication/usecase.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/shared_widgets/alert_widget.dart';
import '../../../core/shared_widgets/loading_widgets.dart';

class ProfileController extends GetxController {
  final UserServices _userServices = UserServices();

  final AuthServices authservices = AuthServices();

  Rx<UserModel> user = UserModel().obs;

  RxBool isLoading = true.obs;

  RxString imageUrl = ''.obs;

  final imagePicker = ImagePicker();

  Future<UserModel> getUserDetail() async {
    return await _userServices.getUserDetails();
  }

  Future<void> takeCameraImage() async {
    File _image;

    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      update();

      await updateProfile(_image);
    }
  }

  updateProfile(File file) async {
    showLoading(Get.context!);
    String res = await _userServices.updateProfilePhoto(file);
    if (res == 'success') {
      Get.back();
    } else {
      Get.back();
      showErrorAlertWidget(Get.context!, message: res);
    }
  }

  Future<void> pickFromGallery() async {
    File _image;

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      update();

      await updateProfile(_image);
    }
  }
}
