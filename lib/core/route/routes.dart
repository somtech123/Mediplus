import 'package:get/get.dart';

import '../../features/onboarding/screen/onboarding.dart';

class AppRoutes {
  static List<GetPage> appPages = [
    GetPage(
      name: OnboardingScreen.path,
      page: () => OnboardingScreen(),
    ),
  ];
}
