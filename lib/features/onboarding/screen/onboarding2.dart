import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared_widgets/primary_button.dart';
import '../../authentication/login/view/login.dart';
import '../../authentication/sign_up/view/signup.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                SvgPicture.asset(
                  'assets/svgs/medical-icon.svg',
                  height: 150,
                  color: AppColor.primaryColor,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Mediplus",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 28,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Get.height * 0.25,
                ),
                Text(
                  "Welcome to Mediplus",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 20,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 50.h),
                PrimaryButton(
                  label: 'Create an Account',
                  onPressed: () {
                    Get.to(() => SignUPSceen());
                  },
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                  label: 'Sign in',
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  backgroundColor: AppColor.secondary,
                  labelColor: AppColor.primaryColor,
                  borderColor: AppColor.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
