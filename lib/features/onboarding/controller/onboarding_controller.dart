import 'package:get/get.dart';

import '../model/onboarding_model.dart';

class OnboardingController extends GetxController {
  final List<OnboardingModel> _onboard = <OnboardingModel>[
    OnboardingModel(
        'assets/images/doc2.jpg',
        "Find the best doctor in your vicinity!",
        "locate top rated medical professionals near you for exceptional care"),
    OnboardingModel('assets/images/doc1.jpg', "Book face-to-face Appointment!",
        "Request a face to face Appointment"),
    OnboardingModel(
        'assets/images/doc4.jpg',
        "Schedule appointments with expert doctors!",
        "Access Expert Mediacl Advice with a Qick Appointment")
  ];

  List<OnboardingModel> get onBoarding {
    return [..._onboard];
  }
}
