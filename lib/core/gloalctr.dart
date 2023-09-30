import 'package:get/get.dart';
import 'package:mediplus/core/services/authentication/model/user_model.dart';
import 'package:mediplus/core/services/user/usecase.dart';

class GlobalController extends GetxController {
  final UserServices _userServices = UserServices();

  Rx<UserModel> user = UserModel().obs;

  RxBool isFetching = false.obs;

  Future<bool> getUserInfo() async {
    isFetching.value = false;

    user.value = await _userServices.getUserDetails();

    isFetching.value = true;
    return isFetching.value;
  }

  @override
  void onReady() {
    getUserInfo();
    super.onReady();
  }
}
