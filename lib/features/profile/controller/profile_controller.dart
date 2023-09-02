import 'package:get/get.dart';

import '../../../core/services/authentication/model/user_model.dart';
import '../../../core/services/authentication/usecase.dart';
import '../../../core/services/user/usecase.dart';

class ProfileController extends GetxController {
  final UserServices _userServices = UserServices();

  final AuthServices authservices = AuthServices();

  Rx<UserModel> user = UserModel().obs;

  RxBool isLoading = true.obs;

  Future<UserModel> getUserDetail() async {
    return await _userServices.getUserDetails();
  }
}
