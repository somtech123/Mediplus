import 'package:get/get.dart';

import '../../onboarding/screen/onboarding.dart';

class SplashController extends GetxController {
  moveToNext() async {
    Future.delayed(const Duration(seconds: 3), () {
      checkIfUserIsLoggedIn();
    });
  }

  checkIfUserIsLoggedIn() {
    Get.offAllNamed(OnboardingScreen.path);
  }

  @override
  void onReady() {
    moveToNext();
    super.onReady();
  }
}
