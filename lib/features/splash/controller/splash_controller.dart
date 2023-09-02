import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../bottom_tab/screen/bottom_tab.dart';
import '../../onboarding/screen/onboarding.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  moveToNext() async {
    Future.delayed(const Duration(seconds: 3), () {
      checkIfUserIsLoggedIn();
    });
  }

  checkIfUserIsLoggedIn() {
    final User? user = _auth.currentUser;
    if (user == null) {
      Get.offAllNamed(OnboardingScreen.path);
    } else {
      Get.offAll(() => const BottomTab());
    }
  }

  @override
  void onReady() {
    moveToNext();
    super.onReady();
  }
}
